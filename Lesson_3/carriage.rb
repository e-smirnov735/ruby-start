# frozen_string_literal: true

require_relative 'manufacturer'

# Carriage base
class Carriage
  include Manufacturer
  attr_reader :type

  def initialize
    @type = 'default'
  end
end
