module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, arg = nil)
      @validations ||= []
      var = instance_variable_get("@#{name}")
      @validations.push({ type: type, params: [var, arg] })
      p @validations
      ps self.class.validations
    end

    protected

    def presense(name)
      'Имя не должно быть пустым' if name.nil? || name.to_s.strip.empty?
    end

    def format(name, arg)
      -> { 'Неправильный формат' if name !~ arg }
    end

    def type(name, arg)
      'Несоответствие типа' unless name.instance_of?(arg)
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StartandError
      false
    end

    def validate!
      errors = []
      self.class.validations.each do |validate|
        errors << send(validate[:type], *validate[:params])
      end

      raise puts errors.compact if errors.any?
    end
  end
end
