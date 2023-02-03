# frozen_string_literal: true

require_relative 'carriage'
require_relative 'manufacturer'
require_relative 'instance_counter'

# class Train
class Train
  include InstanceCounter
  include Manufacturer

  @@station_instances = []

  attr_reader :speed, :type, :carriages, :number

  init_counter

  def initialize(number, carriages = [], route = nil)
    @number = number
    @speed = 0
    @route = route
    @carriages = carriages
    @type = 'default'
    @@station_instances.push(self)
    register_instance

    return unless route

    stations(route)
    add_train_to_start_station
    @station_index = station_index
  end

  def self.find(number)
    @@station_instances.find { |train| train.number == number }
  end

  def route=(route)
    @route = route
    stations(route)
    add_train_to_start_station
    @station_index = station_index
  end

  def stations(route)
    @stations = route.stations
  end

  def add_train_to_start_station
    @stations.first.add_train(self)
  end

  def go_to_next_station
    if @station_index == @stations.size - 1
      puts 'ошибка: конечная станция.'
      return
    end

    @stations[@station_index].remove_train(self)
    @stations[@station_index + 1].add_train(self)
    @station_index += 1
  end

  def go_to_previous_station
    if @station_index.zero?
      puts 'ошибка: начальная станция.'
      return
    end

    @stations[@station_index].remove_train(self)
    @stations[@station_index - 1].add_train(self)
    @station_index = -1
  end

  def current_station
    @stations[@station_index]
  end

  def next_station
    if @station_index == @stations.size - 1
      puts 'ошибка; поезд на конечной станции'
      return
    end

    @stations[@station_index + 1]
  end

  def previous_station
    if @station_index.zero?
      puts 'ошибка: поезд на начальной станции.'
      return
    end

    @stations[@station_index - 1]
  end

  def add_carriage(carriage)
    puts 'ошибка: поезд в движении. Прицепить вагон невозможно' unless @speed.zero?

    if carriage.type != type
      puts 'ошибка: Несовместимый тип вагона'
      return
    end

    @carriages.push(carriage)
  end

  def remove_carriage
    if @speed.positive?
      puts 'ошибка: поезд в движении. Прицепить вагон невозможно'
      return
    end

    if @carriages.empty?
      puts 'ошибка: Нет вагонов, которые можно отцепить'
      return
    end

    @carriages.pop
  end

  def up_speed
    @speed = 50
  end

  def down_speed
    @speed = 0
  end

  def to_s
    "Поезд №#{@number}\tтип: #{@type}\tвагонов: #{@carriages.size}"
  end

  protected # метод необходим только самому классу и потомкам

  def station_index
    idx = 0
    @stations.each_with_index { |st, i| idx = i if st.trains.include?(self) }
    idx
  end
end
