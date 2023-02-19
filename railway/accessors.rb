module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |arg|
        return if arg == instance_variable_get(var_name)

        arr_name = "@log_#{name}".to_sym
        history = instance_variable_get(arr_name) || []
        history.push(arg)
        instance_variable_set(arr_name, history)

        instance_variable_set(var_name, arg)
      end

      define_method("#{name}_history") do
        arr_name = "@log_#{name}".to_sym
        instance_variable_get(arr_name)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |x|
      raise 'не совпадает класс' unless x.instance_of?(class_name)

      instance_variable_set(var_name, x)
    end
  end
end

class Test
  extend Accessors
  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :cl, String
end
