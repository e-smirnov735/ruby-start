# frozen_string_literal: true

require_relative 'carriage'

# Cargo Carriage
class CargoCarriage < Carriage
  protected

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона' unless type == 'cargo'
  end
end
