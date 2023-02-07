# frozen_string_literal: true

require_relative 'manufacturer'

# Carriage base
class Carriage
  include Manufacturer
  attr_reader :type

  def initialize
    @type = 'default'
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise 'Неправильный тип вагона' unless %w[default cargo passenger].include?(type)
  end
end
