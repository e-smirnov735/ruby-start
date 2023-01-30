# frozen_string_literal: true

require_relative 'train'

# Passenger Train
class PassengerTrain < Train
  def initialize(number, carriages = [], route = nil)
    super(number, carriages, route)
    @type = 'passenger'
  end
end
