# frozen_string_literal: true

class Route
  attr_reader :station_list

  def initialize(start, finish)
    @start = start
    @finish = finish
    @station_list = [@start, @finish]
  end

  def add_station(station)
    @station_list.insert(-1, station)
  end

  def remove_station(station)
    @station_list.delete(station)
  end

  def show_stations
    @station_list.each { |st| puts st }
  end
end
