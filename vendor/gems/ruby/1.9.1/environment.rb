# DO NOT MODIFY THIS FILE
module Bundler
 file = File.expand_path(__FILE__)
 dir = File.dirname(file)

  ENV["GEM_HOME"] = dir
  ENV["GEM_PATH"] = dir

  # handle 1.9 where system gems are always on the load path
  if defined?(::Gem)
    $LOAD_PATH.reject! do |p|
      p != File.dirname(__FILE__) &&
        Gem.path.any? { |gp| p.include?(gp) }
    end
  end

  ENV["PATH"]     = "#{dir}/../../../../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{file} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/configuration-1.1.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.2.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.2.0/ext/json/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.2.0/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.2.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/launchy-0.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/launchy-0.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/heroku-1.6.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/heroku-1.6.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ghi-0.2.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ghi-0.2.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/i18n-0.3.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/memcache-client-1.7.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mime-types-1.16/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rest-client-1.3.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rest-client-1.3.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/abstract-1.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/text-hyphen-1.0.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/text-hyphen-1.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.1.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.1.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-mount-0.4.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-test-0.5.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/text-format-1.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/erubis-2.6.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/erubis-2.6.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mysql-2.8.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mysql-2.8.1/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/tzinfo-0.3.16/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/activesupport/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/activesupport/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mail-2.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/authlogic/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/arel/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/activemodel/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/actionpack/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/activerecord/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/activeresource/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/actionmailer/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/railties/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/railties/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rails/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/dirs/rerails/lib")

  @gemfile = "#{dir}/../../../../Gemfile"

  require "rubygems" unless respond_to?(:gem) # 1.9 already has RubyGems loaded

  @bundled_specs = {}
  @bundled_specs["configuration"] = eval(File.read("#{dir}/specifications/configuration-1.1.0.gemspec"))
  @bundled_specs["configuration"].loaded_from = "#{dir}/specifications/configuration-1.1.0.gemspec"
  @bundled_specs["json"] = eval(File.read("#{dir}/specifications/json-1.2.0.gemspec"))
  @bundled_specs["json"].loaded_from = "#{dir}/specifications/json-1.2.0.gemspec"
  @bundled_specs["rake"] = eval(File.read("#{dir}/specifications/rake-0.8.7.gemspec"))
  @bundled_specs["rake"].loaded_from = "#{dir}/specifications/rake-0.8.7.gemspec"
  @bundled_specs["launchy"] = eval(File.read("#{dir}/specifications/launchy-0.3.5.gemspec"))
  @bundled_specs["launchy"].loaded_from = "#{dir}/specifications/launchy-0.3.5.gemspec"
  @bundled_specs["heroku"] = eval(File.read("#{dir}/specifications/heroku-1.6.5.gemspec"))
  @bundled_specs["heroku"].loaded_from = "#{dir}/specifications/heroku-1.6.5.gemspec"
  @bundled_specs["ghi"] = eval(File.read("#{dir}/specifications/ghi-0.2.4.gemspec"))
  @bundled_specs["ghi"].loaded_from = "#{dir}/specifications/ghi-0.2.4.gemspec"
  @bundled_specs["i18n"] = eval(File.read("#{dir}/specifications/i18n-0.3.3.gemspec"))
  @bundled_specs["i18n"].loaded_from = "#{dir}/specifications/i18n-0.3.3.gemspec"
  @bundled_specs["memcache-client"] = eval(File.read("#{dir}/specifications/memcache-client-1.7.7.gemspec"))
  @bundled_specs["memcache-client"].loaded_from = "#{dir}/specifications/memcache-client-1.7.7.gemspec"
  @bundled_specs["mime-types"] = eval(File.read("#{dir}/specifications/mime-types-1.16.gemspec"))
  @bundled_specs["mime-types"].loaded_from = "#{dir}/specifications/mime-types-1.16.gemspec"
  @bundled_specs["rest-client"] = eval(File.read("#{dir}/specifications/rest-client-1.3.0.gemspec"))
  @bundled_specs["rest-client"].loaded_from = "#{dir}/specifications/rest-client-1.3.0.gemspec"
  @bundled_specs["abstract"] = eval(File.read("#{dir}/specifications/abstract-1.0.0.gemspec"))
  @bundled_specs["abstract"].loaded_from = "#{dir}/specifications/abstract-1.0.0.gemspec"
  @bundled_specs["text-hyphen"] = eval(File.read("#{dir}/specifications/text-hyphen-1.0.0.gemspec"))
  @bundled_specs["text-hyphen"].loaded_from = "#{dir}/specifications/text-hyphen-1.0.0.gemspec"
  @bundled_specs["rack"] = eval(File.read("#{dir}/specifications/rack-1.1.0.gemspec"))
  @bundled_specs["rack"].loaded_from = "#{dir}/specifications/rack-1.1.0.gemspec"
  @bundled_specs["rack-mount"] = eval(File.read("#{dir}/specifications/rack-mount-0.4.5.gemspec"))
  @bundled_specs["rack-mount"].loaded_from = "#{dir}/specifications/rack-mount-0.4.5.gemspec"
  @bundled_specs["rack-test"] = eval(File.read("#{dir}/specifications/rack-test-0.5.3.gemspec"))
  @bundled_specs["rack-test"].loaded_from = "#{dir}/specifications/rack-test-0.5.3.gemspec"
  @bundled_specs["text-format"] = eval(File.read("#{dir}/specifications/text-format-1.0.0.gemspec"))
  @bundled_specs["text-format"].loaded_from = "#{dir}/specifications/text-format-1.0.0.gemspec"
  @bundled_specs["erubis"] = eval(File.read("#{dir}/specifications/erubis-2.6.5.gemspec"))
  @bundled_specs["erubis"].loaded_from = "#{dir}/specifications/erubis-2.6.5.gemspec"
  @bundled_specs["mysql"] = eval(File.read("#{dir}/specifications/mysql-2.8.1.gemspec"))
  @bundled_specs["mysql"].loaded_from = "#{dir}/specifications/mysql-2.8.1.gemspec"
  @bundled_specs["tzinfo"] = eval(File.read("#{dir}/specifications/tzinfo-0.3.16.gemspec"))
  @bundled_specs["tzinfo"].loaded_from = "#{dir}/specifications/tzinfo-0.3.16.gemspec"
  @bundled_specs["builder"] = eval(File.read("#{dir}/specifications/builder-2.1.2.gemspec"))
  @bundled_specs["builder"].loaded_from = "#{dir}/specifications/builder-2.1.2.gemspec"
  @bundled_specs["activesupport"] = eval(File.read("#{dir}/specifications/activesupport-3.0.pre.gemspec"))
  @bundled_specs["activesupport"].loaded_from = "#{dir}/specifications/activesupport-3.0.pre.gemspec"
  @bundled_specs["mail"] = eval(File.read("#{dir}/specifications/mail-2.1.2.gemspec"))
  @bundled_specs["mail"].loaded_from = "#{dir}/specifications/mail-2.1.2.gemspec"
  @bundled_specs["authlogic"] = eval(File.read("#{dir}/specifications/authlogic-2.1.3.gemspec"))
  @bundled_specs["authlogic"].loaded_from = "#{dir}/specifications/authlogic-2.1.3.gemspec"
  @bundled_specs["arel"] = eval(File.read("#{dir}/specifications/arel-0.2.pre.gemspec"))
  @bundled_specs["arel"].loaded_from = "#{dir}/specifications/arel-0.2.pre.gemspec"
  @bundled_specs["activemodel"] = eval(File.read("#{dir}/specifications/activemodel-3.0.pre.gemspec"))
  @bundled_specs["activemodel"].loaded_from = "#{dir}/specifications/activemodel-3.0.pre.gemspec"
  @bundled_specs["actionpack"] = eval(File.read("#{dir}/specifications/actionpack-3.0.pre.gemspec"))
  @bundled_specs["actionpack"].loaded_from = "#{dir}/specifications/actionpack-3.0.pre.gemspec"
  @bundled_specs["activerecord"] = eval(File.read("#{dir}/specifications/activerecord-3.0.pre.gemspec"))
  @bundled_specs["activerecord"].loaded_from = "#{dir}/specifications/activerecord-3.0.pre.gemspec"
  @bundled_specs["activeresource"] = eval(File.read("#{dir}/specifications/activeresource-3.0.pre.gemspec"))
  @bundled_specs["activeresource"].loaded_from = "#{dir}/specifications/activeresource-3.0.pre.gemspec"
  @bundled_specs["actionmailer"] = eval(File.read("#{dir}/specifications/actionmailer-3.0.pre.gemspec"))
  @bundled_specs["actionmailer"].loaded_from = "#{dir}/specifications/actionmailer-3.0.pre.gemspec"
  @bundled_specs["railties"] = eval(File.read("#{dir}/specifications/railties-3.0.pre.gemspec"))
  @bundled_specs["railties"].loaded_from = "#{dir}/specifications/railties-3.0.pre.gemspec"
  @bundled_specs["rails"] = eval(File.read("#{dir}/specifications/rails-3.0.pre.gemspec"))
  @bundled_specs["rails"].loaded_from = "#{dir}/specifications/rails-3.0.pre.gemspec"
  @bundled_specs["rerails"] = eval(File.read("#{dir}/specifications/rerails-3.0.pre.1.gemspec"))
  @bundled_specs["rerails"].loaded_from = "#{dir}/specifications/rerails-3.0.pre.1.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; yield if block_given? ; end
      def only(*env)
        old, @only = @only, _combine_only(env.flatten)
        yield
        @only = old
      end
      def except(*env)
        old, @except = @except, _combine_except(env.flatten)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last.is_a?(Hash) ? args.pop : {}
        only = _combine_only(opt[:only] || opt["only"])
        except = _combine_except(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name
        files = [files] unless files.respond_to?(:each)

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        if files = opt[:require_as] || opt["require_as"]
          files = Array(files)
          files.each { |f| require f }
        else
          begin
            require name
          rescue LoadError
            # Do nothing
          end
        end
        yield if block_given?
        true
      end
      private
      def _combine_only(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_except(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile), @gemfile, 1)
  end
end

module Gem
  @loaded_stacks = Hash.new { |h,k| h[k] = [] }

  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end
