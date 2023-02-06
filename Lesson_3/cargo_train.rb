# frozen_string_literal: true

require_relative 'train'

# Cargo Train
class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = 'cargo'
  end
end
