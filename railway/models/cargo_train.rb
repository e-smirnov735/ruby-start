# frozen_string_literal: true

require_relative 'train'

# Cargo Train
class CargoTrain < Train
  validate :number, :presense
  validate :number, :format, NUMBER_EXP

  protected

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона' unless type == 'cargo'
  end
end
