source :rubygems

# Rails
gem "rails", "3.0.3"

# Configuration
gem "mysql2"

gem "passenger"

gem "aasm",      git: "git://github.com/rubyist/aasm.git"
gem "app"
# gem "authlogic", git: "git://github.com/binarylogic/authlogic.git"
gem "authlogic", git: "git://github.com/stephencelis/authlogic.git"
gem "omniauth"
gem "uuid"
gem "resque"
gem "resque-retry"

group :development do
  gem "ghi"
  gem "capistrano"
  gem "heroku"
end

group :test do
  gem "miniskirt"
end

group :production do
  gem "daemons"
end
