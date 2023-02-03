# frozen_string_literal: true

# Instance Counter module
module InstanceCounter
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  # class methods
  module ClassMethods
    def init_counter
      class_variable_set(:@@instances, 0)
    end

    def increment_counter
      count = instances
      class_variable_set(:@@instances, count + 1)
    end

    def instances
      class_variable_get(:@@instances)
    end
  end

  # instance methods
  module InstanceMethods
    private

    def register_instance
      self.class.increment_counter
    end
  end
end
