# frozen_string_literal: true

require_relative './../helpers/manufacturer'
require_relative './../helpers/validator'

CARRIAGE_EXP = /^\d{4}$/.freeze

# Carriage base
class Carriage
  include Validator
  include Manufacturer

  attr_accessor :type, :is_attached
  attr_reader :number, :total_place, :used_place

  def initialize(number, total_place)
    @type = type
    @number = number
    @total_place = total_place
    @used_place = 0
    @is_attached = false
    @type = 'default'
  end

  def take_place
    raise 'Not implemented'
  end

  def free_place
    total_place - used_place
  end

  def to_s
    "Вагон №: #{number}\tтип: #{type}\t"
  end

  protected

  attr_writer :used_place

  def validate!
    raise 'Неправильный тип вагона' unless %w[default cargo passenger].include?(type)
    raise 'неправильный формат номера, номер состоит из 4 цифр' if number !~ CARRIAGE_EXP
  end
end
