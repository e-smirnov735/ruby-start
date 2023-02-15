# frozen_string_literal: true

require_relative 'station'
require_relative './../helpers/instance_counter'
require_relative './../helpers/validator'

# class Route
class Route
  include InstanceCounter
  include Validator
  attr_reader :stations, :name
  attr_accessor :start, :finish

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

  protected

  def validate!
    raise 'Ошибка: должно быть передано 2 параметра' if @start.nil? || @finish.nil?
    raise 'Ошибка: параметры должны быть класса Station' unless @start.is_a?(Station) && @finish.is_a?(Station)
  end
end
