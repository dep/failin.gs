# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{heroku}
  s.version = "1.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Heroku"]
  s.date = %q{2010-01-15}
  s.default_executable = %q{heroku}
  s.description = %q{Client library and command-line tool to manage and deploy Rails apps on Heroku.}
  s.email = %q{support@heroku.com}
  s.executables = ["heroku"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["Rakefile", "bin/heroku", "lib/heroku.rb", "lib/heroku/client.rb", "lib/heroku/command.rb", "lib/heroku/commands/account.rb", "lib/heroku/commands/addons.rb", "lib/heroku/commands/app.rb", "lib/heroku/commands/auth.rb", "lib/heroku/commands/base.rb", "lib/heroku/commands/bundles.rb", "lib/heroku/commands/config.rb", "lib/heroku/commands/db.rb", "lib/heroku/commands/domains.rb", "lib/heroku/commands/help.rb", "lib/heroku/commands/keys.rb", "lib/heroku/commands/logs.rb", "lib/heroku/commands/maintenance.rb", "lib/heroku/commands/plugins.rb", "lib/heroku/commands/ps.rb", "lib/heroku/commands/service.rb", "lib/heroku/commands/sharing.rb", "lib/heroku/commands/ssl.rb", "lib/heroku/commands/version.rb", "lib/heroku/helpers.rb", "lib/heroku/plugin.rb", "lib/heroku/plugin_interface.rb", "spec/base.rb", "spec/client_spec.rb", "spec/command_spec.rb", "spec/commands/addons_spec.rb", "spec/commands/app_spec.rb", "spec/commands/auth_spec.rb", "spec/commands/base_spec.rb", "spec/commands/bundles_spec.rb", "spec/commands/config_spec.rb", "spec/commands/db_spec.rb", "spec/commands/domains_spec.rb", "spec/commands/keys_spec.rb", "spec/commands/logs_spec.rb", "spec/commands/maintenance_spec.rb", "spec/commands/plugins_spec.rb", "spec/commands/ps_spec.rb", "spec/commands/sharing_spec.rb", "spec/commands/ssl_spec.rb", "spec/plugin_spec.rb", "README.md"]
  s.homepage = %q{http://heroku.com/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{heroku}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Client library and CLI to deploy Rails apps on Heroku.}
  s.test_files = ["spec/base.rb", "spec/client_spec.rb", "spec/command_spec.rb", "spec/commands/addons_spec.rb", "spec/commands/app_spec.rb", "spec/commands/auth_spec.rb", "spec/commands/base_spec.rb", "spec/commands/bundles_spec.rb", "spec/commands/config_spec.rb", "spec/commands/db_spec.rb", "spec/commands/domains_spec.rb", "spec/commands/keys_spec.rb", "spec/commands/logs_spec.rb", "spec/commands/maintenance_spec.rb", "spec/commands/plugins_spec.rb", "spec/commands/ps_spec.rb", "spec/commands/sharing_spec.rb", "spec/commands/ssl_spec.rb", "spec/plugin_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.2.0"])
      s.add_development_dependency(%q<taps>, ["~> 0.2.23"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.2"])
      s.add_runtime_dependency(%q<launchy>, ["~> 0.3.2"])
      s.add_runtime_dependency(%q<json>, ["~> 1.2.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 1.2.0"])
      s.add_dependency(%q<taps>, ["~> 0.2.23"])
      s.add_dependency(%q<rest-client>, ["~> 1.2"])
      s.add_dependency(%q<launchy>, ["~> 0.3.2"])
      s.add_dependency(%q<json>, ["~> 1.2.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 1.2.0"])
    s.add_dependency(%q<taps>, ["~> 0.2.23"])
    s.add_dependency(%q<rest-client>, ["~> 1.2"])
    s.add_dependency(%q<launchy>, ["~> 0.3.2"])
    s.add_dependency(%q<json>, ["~> 1.2.0"])
  end
end
