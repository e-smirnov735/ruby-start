# frozen_string_literal: true

require_relative 'train'

# Passenger Train
class PassengerTrain < Train
  protected

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона !!!' unless type == 'passenger'
  end
end
