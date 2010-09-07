# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ghi}
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Celis"]
  s.date = %q{2009-12-28}
  s.default_executable = %q{ghi}
  s.description = %q{GitHub Issues on the command line. Use your `$EDITOR`, not your browser.}
  s.email = ["stephen@stephencelis.com"]
  s.executables = ["ghi"]
  s.extra_rdoc_files = ["History.rdoc", "Manifest.txt", "README.rdoc"]
  s.files = ["History.rdoc", "Manifest.txt", "README.rdoc", "bin/ghi", "lib/ghi/api.rb", "lib/ghi/cli.rb", "lib/ghi/issue.rb", "lib/ghi.rb", "spec/ghi/api_spec.rb", "spec/ghi/cli_spec.rb", "spec/ghi/issue_spec.rb", "spec/ghi_spec.rb"]
  s.homepage = %q{http://github.com/stephencelis/ghi}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ghi}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{GitHub Issues on the command line}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
