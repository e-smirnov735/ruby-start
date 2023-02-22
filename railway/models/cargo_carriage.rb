# frozen_string_literal: true

require_relative 'carriage'

# Cargo Carriage
class CargoCarriage < Carriage
  validate :number, :format, CARRIAGE_EXP
  validate :total_place, :type, Integer

  def initialize(number, total_place)
    super(number, total_place)
    @type = 'cargo'
    validate!
  end

  def take_place(place)
    raise 'превышение вместимости' if used_place + place > total_place

    self.used_place += place
  end

  def to_s
    super + "занятый объём: #{used_place}\tсвободный объём: #{free_place}"
  end

  protected

  def validate!
    super
    raise 'Ошибка: неправильный тип вагона' unless type == 'cargo'
    return unless (total_place - used_place).negative?

    raise 'Ошибка: вместимость меньше, чем уже загружено'
  end
end
