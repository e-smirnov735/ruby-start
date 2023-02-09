# frozen_string_literal: true

require_relative 'carriage'

# Cargo Carriage
class CargoCarriage < Carriage
  attr_accessor :total_volume
  attr_reader :loaded_volume

  def initialize(type, number, total_volume = 50_000)
    super(type, number)
    @total_volume = total_volume
    @loaded_volume = 0
  end

  def upload_volume(volume)
    raise 'превышение вместимости' if loaded_volume + volume > total_volume

    self.loaded_volume += volume
  end

  def free_volume
    total_volume - loaded_volume
  end

  def to_s
    super + "занятый объём: #{loaded_volume}\tсвободный объём: #{free_volume}"
  end

  protected

  attr_writer :loaded_volume

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона' unless type == 'cargo'
    raise 'Ошибка: параметром оъёма вагона является число' unless total_volume.is_a?(Numeric)
    raise 'Ошибка: вместимость меньше, чем уже загружено' if (total_volume - loaded_volume).negative?
  end
end
