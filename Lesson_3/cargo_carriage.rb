# frozen_string_literal: true

require_relative 'carriage'

# Cargo Carriage
class CargoCarriage < Carriage
  def initialize
    super
    @type = 'cargo'
  end
end
