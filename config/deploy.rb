set :application, 'failings'
set :repository,  'git@github.com:dep:failin.gs.git'
set :branch,      'origin/master'
set :user,        application
set :deploy_type, 'deploy'
set :deploy_to,   "/home/#{user}"
set :rails_env,   "production"

set :main_ip, "69.164.196.172"
role :app, main_ip
role :web, main_ip
role :db,  main_ip, primary: true

namespace :deploy do
  desc "Setup a GitHub-style deployment."
  task :setup, except: { no_release: true } do
    run "git clone #{repository} #{current_path}"
  end

  desc "Deploys your project."
  task :default do
    fetch
    update_code
    bundle if ENV["BUNDLE"]
    cleanup
    restart
  end

  desc "Deploy and run pending migrations."
  task :migrations do
    after "deploy:bundle", "deploy:migrate"
    deploy.default
  end

  desc "Fetch new code"
  task :fetch do
    run "cd #{current_path} && git fetch origin"
  end

  desc "Update the deployed code."
  task :update_code, except: { no_release: true } do
    set :tag, "#{Time.now.to_i}-#{deploy_type}"

    run [
      "cd #{current_path}",
      "git reset --hard #{branch}",
      "git tag '#{tag}'"
    ].join(" && ")
  end

  desc "Bundle gems."
  task :bundle, except: { no_release: true } do
    run "cd #{current_path} && bundle install"
  end

  desc "Run the migrate rake task."
  task :migrate, roles: :db, only: { primary: true } do
    run [
      "cd #{current_path}",
      "bundle exec rake RAILS_ENV=#{rails_env} db:migrate"
    ].join(" && ")
  end

  desc "Clean up the current release."
  task :cleanup do
    cleanup_paths = %w(tmp/* public/*)

    run [
      "cd #{current_path}",
      "git clean -fx #{cleanup_paths.join(" ")}"
    ].join(" && ")
  end

  desc "List tags for deploy:rollback TAG="
  task :list_tags, except: { no_release: true } do
    run [
      "cd #{current_path}",
      "git tag -l '*-deploy' | tail -3"
    ].join(" && ")
  end

  namespace :rollback do
    desc "Rollback a single commit, or to a specific TAG"
    task :default, except: { no_release: true } do
      branch = ENV["TAG"] || capture([
        "cd #{current_path}", "git tag -l '*-deploy' | tail -2 | head -1"
      ].join(" && "))

      set :deploy_type, "rollback"
      set :branch, branch
      deploy.default
    end
  end

  desc "Signal Passenger to restart the application"
  task :restart, roles: :app do
    run [
      "cd #{current_path}",
      "mkdir -p tmp/pids",
      "touch tmp/restart.txt",
      "script/job_runner restart"
    ].join(" && ")
  end

  task(:cold) { deploy.default }
end

namespace :logs do
  desc "Watch jobs log"
  task :default do
    sudo "tail -f #{current_path}/log/production.log"
  end
end
