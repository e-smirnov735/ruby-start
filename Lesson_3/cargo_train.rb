# frozen_string_literal: true

require_relative 'train'

# Cargo Train
class CargoTrain < Train
  def initialize(number, carriages = [], route = nil)
    super(number, carriages, route)
    @type = 'cargo'
  end
end
