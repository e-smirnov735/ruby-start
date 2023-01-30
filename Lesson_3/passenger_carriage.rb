# frozen_string_literal: true

require_relative 'carriage'

# Passenger Carriage
class PassengerCarriage < Carriage
  def initialize
    super
    @type = 'passenger'
  end
end
