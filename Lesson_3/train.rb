# frozen_string_literal: true

# class Train
class Train
  attr_reader :speed, :carriage_count, :type

  def initialize(number, type, carriage_count = 0, route = nil)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @route = route

    return unless route

    stations(route)
    add_train_to_start_station
    @station_index = station_index
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
      puts 'конечная станция'
      return
    end

    @stations[@station_index].remove_train(self)
    @stations[@station_index + 1].add_train(self)
    @station_index += 1
  end

  def go_to_previous_station
    if @station_index.zero?
      puts 'начальная станция.'
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
      puts 'конечная станция'
      return
    end

    @stations[@station_index + 1]
  end

  def previous_station
    if @station_index.zero?
      puts 'начальная станция.'
      return
    end

    @stations[@station_index - 1]
  end

  def add_carriage
    puts 'поезд в движении. Прицепить вагон невозможно' unless @speed.zero?

    self.carriage_count += 1
  end

  def remove_carriage
    unless @speed.zero?
      puts 'поезд в движении. Прицепить вагон невозможно'
      return
    end

    unless @carriage_count.positive?
      puts 'Нет вагонов, которые можно отцепить'
      return
    end

    self.carriage_count -= 1
  end

  def up_speed
    @speed = 50
  end

  def down_speed
    @speed = 0
  end

  private

  def station_index
    idx = 0
    @stations.each_with_index { |st, i| idx = i if st.trains.include?(self) }
    idx
  end
end
