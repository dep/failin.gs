class ActionView::Helpers::FormBuilder #:nodoc:
  def label_with_block(method, *args, &block)
    if block_given?
      options = args.extract_options!
      text = @template.capture(&block)
      @template.concat label_without_block(method, text, options)
    else
      label_without_block(method, *args)
    end
  end

  alias_method_chain :label, :block
end

module ApplicationHelper
  def label_tag(*args, &block)
    if block_given?
      options = args.extract_options!
      name = args.shift
      text = capture(&block)
      concat super(name, text, options)
    else
      super
    end
  end

  def label(object_name, *args, &block)
    if block_given?
      options = args.extract_options!
      method = args.shift
      text = capture(&block)
      concat super(object_name, method, text, options)
    else
      super
    end
  end
end
