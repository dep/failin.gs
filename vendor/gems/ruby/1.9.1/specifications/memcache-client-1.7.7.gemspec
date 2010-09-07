# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{memcache-client}
  s.version = "1.7.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Hodel", "Robert Cottrell", "Mike Perham"]
  s.date = %q{2009-11-24}
  s.description = %q{A Ruby library for accessing memcached.}
  s.email = %q{mperham@gmail.com}
  s.extra_rdoc_files = ["LICENSE.txt", "README.rdoc"]
  s.files = ["FAQ.rdoc", "History.rdoc", "LICENSE.txt", "README.rdoc", "Rakefile", "VERSION.yml", "lib/continuum_native.rb", "lib/continuum_native.rbc", "lib/memcache.rb", "lib/memcache.rbc", "lib/memcache_util.rb", "performance.txt", "test/test_benchmark.rb", "test/test_benchmark.rbc", "test/test_mem_cache.rb", "test/test_mem_cache.rbc"]
  s.homepage = %q{http://github.com/mperham/memcache-client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{seattlerb}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A Ruby library for accessing memcached.}
  s.test_files = ["test/test_benchmark.rb", "test/test_mem_cache.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
