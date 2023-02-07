# frozen_string_literal: true

require_relative 'carriage'

# Passenger Carriage
class PassengerCarriage < Carriage
  protected

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона' unless type == 'passenger'
  end
end
