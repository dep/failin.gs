# See App (config/app.rb).
class Configurable
  autoload :OpenStruct, "ostruct"

  class << self
    alias __name__ name
    undef name

    alias configure class_eval

    def [](key)
      config.send key
    end

    def inspect
      config.inspect.sub config.class.name, __name__
    end

    private

    def config
      @config ||= OpenStruct.new
    end

    def method_missing(method, *args)
      super if (key = method.to_s).end_with?("=")
      boolean = key.chomp!("?")
      value   = self[key]
      value   = value.call(*args) if value.respond_to?(:call)
      boolean ? !!value : value
    end

    def inherited(subclass)
      return unless defined? Rails

      config = Rails.root.
        join "config", File.basename(__FILE__, ".rb"), Rails.env

      load config if File.exist?(config)
    end
  end
end
