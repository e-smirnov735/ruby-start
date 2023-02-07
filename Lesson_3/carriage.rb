# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validator'

# Carriage base
class Carriage
  include Validator
  include Manufacturer

  attr_accessor :type

  def initialize(type)
    @type = type
  end

  protected

  def validate!
    raise 'Неправильный тип вагона' unless %w[default cargo passenger].include?(type)
  end
end
