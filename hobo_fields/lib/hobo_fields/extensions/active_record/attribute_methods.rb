ActiveRecord::Base.class_eval do
  def _read_attribute_with_hobo(attr_name)
    if self.class.can_wrap_with_hobo_type?(attr_name)
      val = _read_attribute_without_hobo(attr_name)
      wrapper_type = self.class.attr_type(attr_name.to_sym)
      if HoboFields.can_wrap?(wrapper_type, val)
        wrapper_type.new(val)
      else
        val
      end
    else
      _read_attribute_without_hobo(attr_name)
    end
  end
  alias_method_chain :_read_attribute, :hobo

  class << self

    def can_wrap_with_hobo_type?(attr_name)
      @can_wrap_cache ||= {}
      if @can_wrap_cache.include?(attr_name)
        @can_wrap_cache[attr_name]
      else
        @can_wrap_cache[attr_name.to_s] = \
          if connected?
            type_wrapper = try.attr_type(attr_name)
            type_wrapper.is_a?(Class) && type_wrapper.not_in?(HoboFields::PLAIN_TYPES.values)
          else
            false
          end
        @can_wrap_cache[attr_name.to_sym] = @can_wrap_cache[attr_name.to_s]
      end
    end

    def define_method_attribute=(attr_name)
      if can_wrap_with_hobo_type?(attr_name)
        src = "begin; wrapper_type = self.class.attr_type(#{attr_name.to_sym.inspect}); " +
          "if !new_value.is_a?(wrapper_type) && HoboFields.can_wrap?(wrapper_type, new_value); wrapper_type.new(new_value); else; new_value; end; end"
        generated_attribute_methods.module_eval("def #{attr_name}=(new_value); write_attribute(#{attr_name.to_s.inspect}, #{src}); end", __FILE__, __LINE__)
      else
        super
      end
    end

  end
end
