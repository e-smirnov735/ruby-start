# frozen_string_literal: true

require_relative 'carriage'

# Passenger Carriage
class PassengerCarriage < Carriage
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
    raise 'Ошибка: неправильный тип вагона' unless type == 'passenger'
    raise 'Ошибка: количество мест передается в числовом формате' unless total_place.is_a?(Integer)
    raise 'Количество мест должно быть положительно' if total_place <= 0
  end
end
