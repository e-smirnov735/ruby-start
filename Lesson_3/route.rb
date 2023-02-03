# frozen_string_literal: true

require_relative 'station'
require_relative 'instance_counter'

# class Route
class Route
  include InstanceCounter
  attr_reader :stations, :name

  init_counter

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
    @name = "#{@start.name} - #{@finish.name}"
    register_instance
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.map(&:name).join(' - ')
  end

  def to_s
    show_stations
  end
end
