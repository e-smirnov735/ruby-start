# frozen_string_literal: true

require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

# Storage class
class Storage
  attr_reader :trains, :stations, :routes

  def initialize
    @stations = [Station.new('msk'), Station.new('spb'), Station.new('sochi')]
    @trains = [CargoTrain.new(111), PassengerTrain.new(222), CargoTrain.new(333)]
    @routes = []
  end

  def create_station(name)
    station = Station.new(name)
    @stations.push(station)
  end

  def create_train(train_number, train_type)
    train = nil

    case train_type
    when 'cargo'
      train = CargoTrain.new(train_number)
    when 'passenger'
      train = PassengerTrain.new(train_number)
    else
      puts 'неправильный ввод типа'
      return
    end

    @trains.push(train)
  end

  def create_route(first, last)
    first_station = find_station(first)
    unless first_station
      puts 'нет такой станции, сначала создайте её'
      return
    end

    last_station = find_station(last)

    unless last_station
      puts 'нет такой станции, сначала создайте её'
      return
    end

    route = Route.new(first_station, last_station)
    @routes.push(route)
  end

  def add_station_to_route(station_name, route_name)
    station = find_station(station_name)
    unless station
      puts 'нет такой станции, сначала создайте её'
      return
    end

    route = find_route(route_name)
    unless route
      puts 'нет такого маршрута, сначала создайте его'
      return
    end

    route.add_station(station)
  end

  def remove_station_on_route(station_name, route_name)
    station = find_station(station_name)
    unless station
      puts 'нет такой станции, сначала создайте её'
      return
    end

    route = find_route(route_name)
    unless route
      puts 'нет такого маршрута, сначала создайте его'
      return
    end

    route.remove_station(station)
  end

  def set_route_to_train(route_name, train_number)
    route = find_route(route_name)
    train = find_train(train_number)
    train.route = route
  end

  def add_carriage_to_train(carriage_type, train_number)
    carriage = nil

    case carriage_type
    when 'cargo'
      carriage = CargoCarriage.new
    when 'passenger'
      carriage = PassengerCarriage.new
    else
      puts 'неправильно задан тип вагона'
    end

    train = find_train(train_number)
    train.add_carriage(carriage) if train
  end

  def remove_carriage_from_train(train_number)
    train = find_train(train_number)
    train.remove_carriage
  end

  def go_to_next_station(train_number)
    train = find_train(train_number)
    train.go_to_next_station
  end

  def go_to_previous_station(train_number)
    train = find_train(train_number)
    train.go_to_previous_station
  end

  def show_info
    puts '-' * 10
    show_data('trains', @trains)
    show_data('stations', @stations)
    show_data('routes', @routes)
    puts '-' * 10
  end

  private # методы требуются только внутри класса

  def show_data(name, arr)
    puts "#{name} list: "
    if arr.empty?
      puts "\t---empty list"
      return
    end

    arr.each { |item| puts "\t#{item}" }
  end

  def find_route(name)
    @routes.find { |r| r.name == name }
  end

  def find_train(number)
    @trains.find { |tr| tr.number == number }
  end

  def find_station(name)
    @stations.find { |st| st.name == name }
  end
end
