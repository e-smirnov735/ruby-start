# frozen_string_literal: true

require_relative 'storage'

START_MENU = {
  1 => 'создать станцию',
  2 => 'создать поезд',
  3 => 'создать маршрут',
  4 => 'назначить маршрут поезду',
  5 => 'добавить вагон к поезду',
  6 => 'отцепить вагон от поезда',
  7 => 'перместить поезд на следующую станцию',
  8 => 'переместить поезд на предыдущую станцию',
  9 => 'Добавить станцию в маршрут',
  10 => 'Убрать станцию из маршрута',
  11 => 'просмотреть список станций, список поездов, список маршрутов',
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
    when '4' then set_route_to_train
    when '5' then add_carriage_to_train
    when '6' then remove_carriage_from_train
    when '7' then go_to_next_station
    when '8' then go_to_previous_station
    when '9' then add_station_to_route
    when '10' then remove_station_from_route
    when '11' then @storage.show_info
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

  def set_route_to_train
    puts 'введите номер поезда: '
    train_number = gets.chomp.to_i
    puts 'введите маршрут на который поставить поезд в формате: "город - город2": '
    route_name = gets.chomp
    @storage.set_route_to_train(route_name, train_number)
  end

  def add_carriage_to_train
    puts 'введите номер поезда: '
    train_number = gets.chomp.to_i
    puts 'введите тип вагона (cargo / passenger): '
    carriage_type = gets.chomp
    @storage.add_carriage_to_train(carriage_type, train_number)
  end

  def remove_carriage_from_train
    puts 'введите номер поезда: '
    train_number = gets.chomp.to_i
    @storage.remove_carriage_from_train(train_number)
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

  def seed
    @storage.create_station('msk')
    @storage.create_station('spb')
    @storage.create_station('sochi')
    @storage.create_train('AA1-FF', 'cargo')
    @storage.create_train('AS3-WW', 'passenger')
    @storage.create_route('msk', 'spb')
    @storage.add_station_to_route('sochi', 'msk - spb')
    @storage.set_route_to_train('msk - spb', 'AA1-FF')
    @storage.go_to_next_station('AA1-FF')
    @storage.go_to_previous_station('AA1-FF')
    @storage.add_carriage_to_train('passenger', 'AS3-WW')
    puts('----test---')
    puts "Количество Станций: #{Station.instances}"
    puts "Количество маршрутов: #{Route.instances}"
    puts "Количество поездов: #{Train.instances}"
    puts('---test---')
  end

  def show_menu
    @start_menu.each { |key, value| puts "#{key}, #{value}" }
  end
end

app = Control.new
app.start
