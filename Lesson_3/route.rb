# frozen_string_literal: true

# class Route
class Route
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.each { |st| puts st }
  end
end
