# frozen_string_literal: true

require_relative 'station'
require_relative './../helpers/instance_counter'
require_relative './../helpers/validation'

# class Route
class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :name
  attr_accessor :start, :finish

  validate :start, :presense
  validate :finish, :presense
  validate :start, :type, Station
  validate :finish, :type, Station

  init_counter

  def initialize(start, finish)
    @start = start
    @finish = finish
    validate!
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
