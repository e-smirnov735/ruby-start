# frozen_string_literal: true

require_relative 'storage'
require_relative 'testing_data'

START_MENU = {
  1 => 'создать станцию',
  2 => 'создать поезд',
  3 => 'создать маршрут',
  4 => 'создать вагон',
  5 => 'назначить маршрут поезду',
  6 => 'добавить вагон к поезду',
  7 => 'отцепить вагон от поезда',
  8 => 'перместить поезд на следующую станцию',
  9 => 'переместить поезд на предыдущую станцию',
  10 => 'Добавить станцию в маршрут',
  11 => 'Убрать станцию из маршрута',
  12 => 'просмотреть список станций, список поездов, список маршрутов',
  13 => 'Узнать какие поезда стоят на станции',
  14 => 'Узнать какие вагоны прицеплены к поезду',
  15 => 'загрузить вагон',
  16 => 'забронированить места в вагона',
  0 => 'Выход'
}.freeze

# Control Class
class Control
  def initialize
    @start_menu = START_MENU
    @storage = Storage.new
  end

  def start
    seed # загрузка тестовых данных

    loop do
      show_menu
      user_input = gets.chomp
      puts @start_menu[user_input.to_i]
      break if action(user_input) == 'exit'
    end
  end

  private # необходим только внутри класса

  def action(user_input)
    case user_input
    when '1' then add_station
    when '2' then add_train
    when '3' then add_route
    when '4' then add_carriage
    when '5' then set_route_to_train
    when '6' then add_carriage_to_train
    when '7' then remove_carriage_from_train
    when '8' then go_to_next_station
    when '9' then go_to_previous_station
    when '10' then add_station_to_route
    when '11' then remove_station_from_route
    when '12' then @storage.show_info
    when '13' then show_station_trains
    when '14' then show_train_carriages
    when '15' then add_volume_to_carriage
    when '16' then take_seat_to_carriage
    when '0'
      'exit'
    else
      puts "Неправильная команда, попробуйте еще\n"
    end
  end

  def add_station
    puts 'Введите название станции:'
    name = gets.chomp
    @storage.create_station(name)
  end

  def add_train
    puts 'Введите номер поезда: (формат: ASB-AV | 123-AS)'
    train_number = gets.chomp
    puts 'Введите тип поезда (cargo / passenger):'
    train_type = gets.chomp
    @storage.create_train(train_number, train_type)
  end

  def add_route
    puts 'Введите первую станцию: '
    first = gets.chomp.downcase
    puts 'Введите конечную станцию: '
    last = gets.chomp.downcase
    @storage.create_route(first, last)
  end

  def add_carriage
    puts 'Введите тип вагона: '
    type = gets.chomp
    puts 'Введите номер вагона: '
    number = gets.chomp
    case type
    when 'cargo'
      puts 'Введите объём вагона'
      volume = gets.chomp.to_f
      @storage.create_cargo_carriage('cargo', number, volume)
    when 'passenger'
      puts 'Ведите вместимость вагона'
      seats = gets.chomp.to_i
      @storage.create_passenger_carriage('passenger', number, seats)
    else
      puts 'Неправильный тип вагона'
    end
  end

  def set_route_to_train
    puts 'введите номер поезда: '
    train_number = gets.chomp.to_i
    puts 'введите маршрут на который поставить поезд в формате: "город - город2": '
    route_name = gets.chomp
    @storage.set_route_to_train(route_name, train_number)
  end

  def add_carriage_to_train
    puts 'введите номер поезда: '
    train_number = gets.chomp
    puts 'введите тип вагона (cargo / passenger): '
    carriage_type = gets.chomp
    puts 'Введите номер вагона: '
    carriage_number = gets.chomp

    @storage.add_carriage_to_train(carriage_type, carriage_number, train_number)
  end

  def remove_carriage_from_train
    puts 'введите номер поезда: '
    train_number = gets.chomp
    puts 'Введите номер вагона: '
    carriage_number = gets.chomp
    @storage.remove_carriage_from_train(train_number, carriage_number)
  end

  def go_to_next_station
    puts 'введите номер поезда: '
    train_number = gets.chomp.to_i
    @storage.go_to_next_station(train_number)
  end

  def go_to_previous_station
    puts 'введите номер поезда: '
    train_number = gets.chomp.to_i
    @storage.go_to_previous_station(train_number)
  end

  def add_station_to_route
    puts 'введите название станции: '
    station_name = gets.chomp
    puts 'введите маршрут на который добавить станцию '
    route_name = gets.chomp
    @storage.add_station_to_route(station_name, route_name)
  end

  def remove_station_from_route
    puts 'введите название станции: '
    station_name = gets.chomp
    puts 'введите маршрут из которого убрать станцию'
    route_name = gets.chomp
    @storage.remove_station_on_route(station_name, route_name)
  end

  def show_station_trains
    puts 'введите название станции: '
    name = gets.chomp
    @storage.show_station_trains(name)
  end

  def show_train_carriages
    puts 'введите номер поезда: '
    number = gets.chomp
    @storage.show_train_carriages(number)
  end

  def add_volume_to_carriage
    puts 'введите номер вагона: '
    number = gets.chomp
    puts 'введите объем груза: '
    volume = gets.chomp.to_f
    @storage.add_volume_to_carriage(number, volume)
  end

  def take_seat_to_carriage
    puts 'введите номер вагона: '
    number = gets.chomp
    puts 'введите количество мест: '
    volume = gets.chomp.to_i
    @storage.take_seat_to_carriage(number, volume)
  end

  def seed
    @storage.create_station('msk')
    @storage.create_station('spb')
    @storage.create_station('sochi')

    @storage.create_train('AA1-FF', 'cargo')
    @storage.create_train('AA1-DD', 'cargo')
    @storage.create_train('AS3-WW', 'passenger')
    @storage.create_train('AS3-DD', 'passenger')

    @storage.create_route('msk', 'spb')

    @storage.create_cargo_carriage('cargo', '1234', 40_000)
    @storage.create_passenger_carriage('passenger', '9999', 120)
    @storage.create_cargo_carriage('cargo', '5555', 30_000)
    @storage.create_passenger_carriage('passenger', '6666', 220)
    @storage.add_carriage_to_train('passenger', '9999', 'AS3-WW')
    @storage.add_carriage_to_train('cargo', '1234', 'AA1-FF')
    @storage.find_carriage('1234')

    @storage.add_station_to_route('sochi', 'msk - spb')
    @storage.set_route_to_train('msk - spb', 'AA1-FF')
    @storage.go_to_next_station('AA1-FF')
    @storage.go_to_previous_station('AA1-FF')

    @storage.remove_carriage_from_train('AS3-WW', '1234')

    puts('----test---')
    puts "Количество Станций: #{Station.instances}"
    puts "Количество маршрутов: #{Route.instances}"
    puts "Количество поездов: #{Train.instances}"
    puts "Количество вагонов: #{@storage.carriages.size}"
    puts('---test---')
  end

  def show_menu
    @start_menu.each { |key, value| puts "#{key} -> #{value}" }
  end
end

app = Control.new
app.start
