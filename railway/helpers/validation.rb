module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, arg = nil)
      @validations ||= []
      @validations.push([name, type, arg])
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StartandError
      false
    end

    protected

    def presense(name)
      raise 'ОШИБКА! Имя не должно быть пустым' if name.nil? || name.to_s.strip.empty?
    end

    def format(name, arg)
      raise 'ОШИБКА! Неправильный формат' unless name.match(arg)
    end

    def type_of(name, arg)
      raise 'ОШИБКА! Несоответствие типа' unless name.instance_of?(arg)
    end

    def validate!
      self.class.validations.each do |params|
        name = instance_variable_get("@#{params[0]}")
        type = params[1]
        arg = params[2]

        case type
        when :presense
          presense(name)
        when :format
          format(name, arg)
        when :type
          type_of(name, arg)
        end
      end
    end
  end
end
