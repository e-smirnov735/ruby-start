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
    @query = ''
  end

  def start
    seed
    loop do
      show_menu
      query = gets.chomp
      puts @start_menu[query.to_i]
      case query
      when '1'
        puts 'Введите название станции:'
        name = gets.chomp
        @storage.create_station(name)
      when '2'
        puts 'Введите номер поезда:'
        train_number = gets.chomp.to_i
        puts 'Введите тип поезда (cargo / passenger):'
        train_type = gets.chomp
        @storage.create_train(train_number, train_type)
      when '3'
        puts 'Введите первую станцию: '
        first = gets.chomp.downcase
        puts 'Введите конечную станцию: '
        last = gets.chomp.downcase
        @storage.create_route(first, last)
      when '4'
        puts 'введите номер поезда: '
        train_number = gets.chomp.to_i
        puts 'введите маршрут на который поставить поезд в формате: "город - город2": '
        route_name = gets.chomp
        @storage.set_route_to_train(route_name, train_number)
      when '5'
        puts 'введите номер поезда: '
        train_number = gets.chomp.to_i
        puts 'введите тип вагона (cargo / passenger): '
        carriage_type = gets.chomp
        @storage.add_carriage_to_train(carriage_type, train_number)
      when '6'
        puts 'введите номер поезда: '
        train_number = gets.chomp.to_i
        @storage.remove_carriage_from_train(train_number)
      when '7'
        puts 'введите номер поезда: '
        train_number = gets.chomp.to_i
        @storage.go_to_next_station(train_number)
      when '8'
        puts 'введите номер поезда: '
        train_number = gets.chomp.to_i
        @storage.go_to_previous_station(train_number)
      when '9'
        puts 'введите название станции: '
        station_name = gets.chomp
        puts 'введите маршрут на который добавить станцию '
        route_name = gets.chomp
        @storage.add_station_to_route(station_name, route_name)
      when '10'
        puts 'введите название станции: '
        station_name = gets.chomp
        puts 'введите маршрут из которого убрать станцию'
        route_name = gets.chomp
        @storage.remove_station_on_route(station_name, route_name)
      when '11'
        @storage.show_info
      when '0'
        break
      else
        puts 'Неправильная команда, попробуйте еще'
      end
    end
  end

  private # необходим только внутри класса

  def seed
    @storage.create_station('msk')
    @storage.create_station('spb')
    @storage.create_station('sochi')
    @storage.create_train(111, 'cargo')
    @storage.create_train(222, 'passenger')
    @storage.create_route('msk', 'spb')
    @storage.add_station_to_route('sochi', 'msk - spb')
    @storage.set_route_to_train('msk - spb', 111)
    @storage.go_to_next_station(111)
    @storage.go_to_previous_station(111)
    @storage.add_carriage_to_train('passenger', 222)
  end

  def show_menu
    @start_menu.each { |key, value| puts "#{key}, #{value}" }
  end
end

app = Control.new
app.start
