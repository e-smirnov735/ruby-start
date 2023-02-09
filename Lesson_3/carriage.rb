# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validator'

# Carriage base
class Carriage
  include Validator
  include Manufacturer

  attr_accessor :type, :is_attached
  attr_reader :number

  def initialize(type, number)
    @type = type
    @number = number
    @is_attached = false
  end

  def to_s
    "Вагон №: #{number}\tтип: #{type}\t"
  end

  protected

  def validate!
    raise 'Неправильный тип вагона' unless %w[default cargo passenger].include?(type)
  end
end
