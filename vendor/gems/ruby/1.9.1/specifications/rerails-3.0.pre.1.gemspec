# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rerails}
  s.version = "3.0.pre.1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Celis"]
  s.date = %q{2010-01-15}
  s.description = %q{Assorted patches for Rails.}
  s.email = %q{stephen@stephencelis.com}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc"]
  s.files = ["lib/authlogic", "lib/authlogic/controller.rb", "lib/tasks", "CHANGELOG.rdoc", "README.rdoc"]
  s.homepage = %q{http://github.com/stephencelis/rerails}
  s.post_install_message = %q{Remember to explicitly 'require "rerails"' in and initializer or 'after_initialize', or require only the parts you need.
}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Reinforcing the Rails}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.0.pre"])
    else
      s.add_dependency(%q<rails>, ["= 3.0.pre"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.0.pre"])
  end
end
