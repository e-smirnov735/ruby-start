# frozen_string_literal: true

require_relative 'carriage'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validator'

TRAIN_ERRORS = {
  station_last: 'Ошибка: конечная станция',
  station_first: 'Ошибка: начальная станция',
  train_on_finish: 'Ошибка; поезд на конечной станции',
  train_on_start: 'Ошибка: поезд на начальной станции.',
  train_in_motion: 'Ошибка: поезд в движении. Прицепить вагон невозможно',
  carriage_wrong_type: 'Ошибка: Несовместимый тип вагона',
  no_carriages: 'Ошибка: Нет вагонов, которые можно отцепить',
  number_is_nil: 'Ошибка: номер не может быть пустым',
  wrong_number: 'Ошибка: неправильный формат номера.'
}.freeze

NUMBER_EXP = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i.freeze
# class Train
class Train
  include InstanceCounter
  include Manufacturer
  include Validator

  @@train_instances = []

  attr_reader :speed, :carriages, :route
  attr_accessor :number, :type

  init_counter

  def initialize(number, type)
    @number = number
    @speed = 0
    @route = nil
    @carriages = []
    @type = type
    validate!
    @@train_instances.push(self)
    register_instance

    return unless route

    stations(route)
    add_train_to_start_station
    @station_index = station_index
  end

  def self.find(number)
    @@train_instances.find { |train| train.number == number }
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
    raise TRAIN_ERRORS[:station_last] if @station_index == @stations.size - 1

    @stations[@station_index].remove_train(self)
    @stations[@station_index + 1].add_train(self)
    @station_index += 1
  end

  def go_to_previous_station
    raise TRAIN_ERRORS[:station_first] if @station_index.zero?

    @stations[@station_index].remove_train(self)
    @stations[@station_index - 1].add_train(self)
    @station_index = -1
  end

  def current_station
    @stations[@station_index]
  end

  def next_station
    raise TRAIN_ERRORS[:train_on_finish] if @station_index == @stations.size - 1

    @stations[@station_index + 1]
  end

  def previous_station
    raise TRAIN_ERRORS[:train_on_start] if @station_index.zero?

    @stations[@station_index - 1]
  end

  def add_carriage(carriage)
    raise TRAIN_ERRORS[:train_in_motion] unless @speed.zero?
    raise TRAIN_ERRORS[:carriage_wrong_type] if carriage.type != type

    @carriages.push(carriage)
  end

  def remove_carriage(carriage)
    raise TRAIN_ERRORS[:train_in_motion] if @speed.positive?
    raise TRAIN_ERRORS[:no_carriages] if @carriages.empty?

    @carriages.delete(carriage)
  end

  def up_speed
    @speed = 50
  end

  def down_speed
    @speed = 0
  end

  def iteration(&block)
    if @carriages.empty?
      puts 'вагонов нет'
    else
      @carriages.each(&block)
    end
  end

  def to_s
    "Поезд № #{@number}\tтип: #{@type}\tвагонов: #{@carriages.size}"
  end

  protected # метод необходим только самому классу и потомкам

  def validate!
    raise TRAIN_ERRORS[:number_is_nil] if number.nil?
    raise TRAIN_ERRORS[:wrong_number] if number !~ NUMBER_EXP
  end

  def station_index
    idx = 0
    @stations.each_with_index { |st, i| idx = i if st.trains.include?(self) }
    idx
  end
end
