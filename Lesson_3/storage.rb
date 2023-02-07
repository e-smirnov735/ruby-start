# frozen_string_literal: true

require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'train'
require_relative 'route'

STORAGE_ERRORS = {
  station_exist: 'такая станция уже существует',
  train_exist: 'поезд с таким номером уже существует',
  route_exist: 'такой маршрут уже существует',
  wrong_train_type: 'неправильный указан тип поезда',
  wrong_carriage_type: 'неправильный указан тип вагона',
  route_not_found: 'маршрут с таким именем не найден',
  train_not_found: 'поезд с таким номером не найден',
  station_not_found: 'станция с таким именем не найдена'
}.freeze

# Storage class
class Storage
  attr_reader :trains, :stations, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def create_station(name)
    raise STORAGE_ERRORS[:station_exist] if station_exist?(name)

    station = Station.new(name)
    @stations.push(station)
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def create_train(train_number, train_type)
    raise STORAGE_ERRORS[:wrong_train_type] unless %w[cargo passenger].include?(train_type)
    raise STORAGE_ERRORS[:train_exist] if train_exist?(train_number)

    train = CargoTrain.new(train_number, train_type) if train_type == 'cargo'
    train = PassengerTrain.new(train_number, train_type) if train_type == 'passenger'

    @trains.push(train)
    puts "Создан #{train}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def create_route(first, last)
    raise STORAGE_ERRORS[:route_exist] if route_exist?(first, last)

    first_station = find_station(first)
    last_station = find_station(last)
    route = Route.new(first_station, last_station)
    @routes.push(route)
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def add_station_to_route(station_name, route_name)
    station = find_station(station_name)
    route = find_route(route_name)
    route.add_station(station)
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def remove_station_on_route(station_name, route_name)
    station = find_station(station_name)
    route = find_route(route_name)
    route.remove_station(station)
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def set_route_to_train(route_name, train_number)
    route = find_route(route_name)
    train = find_train(train_number)
    train.route = route
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def add_carriage_to_train(carriage_type, train_number)
    raise STORAGE_ERRORS[:wrong_carriage_type] unless %w[cargo passenger].include?(carriage_type)

    carriage = CargoCarriage.new(carriage_type) if carriage_type == 'cargo'
    carriage = PassengerCarriage.new(carriage_type) if carriage_type == 'passenger'
    train = find_train(train_number)
    train.add_carriage(carriage)
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def remove_carriage_from_train(train_number)
    train = find_train(train_number)
    train.remove_carriage
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def go_to_next_station(train_number)
    train = find_train(train_number)
    train.go_to_next_station
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def go_to_previous_station(train_number)
    train = find_train(train_number)
    train.go_to_previous_station
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
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

  11

  def find_route(name)
    result = @routes.find { |r| r.name == name }
    raise STORAGE_ERRORS[:route_not_found] unless result

    result
  end

  def find_train(number)
    result = @trains.find { |tr| tr.number == number }
    raise STORAGE_ERRORS[:train_not_found] unless result

    result
  end

  def find_station(name)
    result = @stations.find { |st| st.name == name }
    raise STORAGE_ERRORS[:station_not_found] unless result

    result
  end

  def train_exist?(number)
    @trains.any? { |tr| tr.number == number }
  end

  def route_exist?(first, last)
    name = "#{first} - #{last}"
    @routes.any? { |r| r.name == name }
  end

  def station_exist?(name)
    @stations.find { |st| st.name == name }
  end

end
