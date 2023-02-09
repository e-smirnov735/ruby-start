# frozen_string_literal: true

require_relative 'carriage'

# Passenger Carriage
class PassengerCarriage < Carriage
  attr_accessor :total_seats
  attr_reader :occupied_seats

  def initialize(type, number, total_seats = 100)
    super(type, number)
    @total_seats = total_seats
    @occupied_seats = 0
  end

  def take_seat
    raise 'Ошибка: нет свободных мест' if occupied_seats == total_seats

    self.occupied_seats += 1
  end

  def free_seats
    total_seats - occupied_seats
  end

  def to_s
    super + "количество мест: #{total_seats}"
  end

  protected

  attr_writer :occupied_seats

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона' unless type == 'passenger'
    raise 'Ошибка: количество мест передается в числовом формате' unless total_seats.is_a?(Integer)
    raise 'Количество мест должно быть положительно' unless total_seats <= 0
  end
end
