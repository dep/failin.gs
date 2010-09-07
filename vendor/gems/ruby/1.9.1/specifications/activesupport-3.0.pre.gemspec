# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{activesupport}
  s.version = "3.0.pre"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.date = %q{2009-09-01}
  s.description = %q{Utility library which carries commonly used classes and goodies from the Rails framework}
  s.email = %q{david@loudthinking.com}
  s.files = ["README", "lib/authlogic", "lib/authlogic/controller.rb", "lib/tasks"]
  s.homepage = %q{http://www.rubyonrails.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{activesupport}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Support and utility classes used by the Rails framework.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<i18n>, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<tzinfo>, ["~> 0.3.16"])
      s.add_runtime_dependency(%q<builder>, ["~> 2.1.2"])
      s.add_runtime_dependency(%q<memcache-client>, ["~> 1.7.5"])
    else
      s.add_dependency(%q<i18n>, ["~> 0.3.0"])
      s.add_dependency(%q<tzinfo>, ["~> 0.3.16"])
      s.add_dependency(%q<builder>, ["~> 2.1.2"])
      s.add_dependency(%q<memcache-client>, ["~> 1.7.5"])
    end
  else
    s.add_dependency(%q<i18n>, ["~> 0.3.0"])
    s.add_dependency(%q<tzinfo>, ["~> 0.3.16"])
    s.add_dependency(%q<builder>, ["~> 2.1.2"])
    s.add_dependency(%q<memcache-client>, ["~> 1.7.5"])
  end
end
