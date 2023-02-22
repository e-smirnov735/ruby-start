# frozen_string_literal: true

require_relative 'carriage'

# Passenger Carriage
class PassengerCarriage < Carriage
  validate :number, :format, CARRIAGE_EXP
  validate :total_place, :type, Integer

  def initialize(number, total_place)
    super(number, total_place)
    @type = 'passenger'
    validate!
  end

  def take_place
    raise 'Ошибка: нет свободных мест' if used_place == total_place

    self.used_place += 1
  end

  def to_s
    super + "занято мест: #{used_place}\tсвободных мест: #{free_place}"
  end

  def validate!
    super
    raise 'from carriage Ошибка: неправильный тип вагона' unless type == 'passenger'
    raise 'Количество мест должно быть положительно' if total_place <= 0
  end
end
