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
  15 => 'загрузить объём груза в вагон',
  16 => 'забронированить места в пассажирском вагоне',
  0 => 'Выход'
}.freeze

# Control Class
class App
  def initialize(storage)
    @start_menu = START_MENU
    @storage = storage
  end

  def start
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
    name = ask('Введите название станции:')
    @storage.create_station(name)
  end

  def add_train
    train_number = ask('Введите номер поезда: (формат: ASB-AV | 123-AS)')
    train_type = ask('Введите тип поезда (cargo / passenger):')
    @storage.create_train(train_number, train_type)
  end

  def add_route
    first = ask('Введите первую станцию: ').downcase
    last = ask('Введите конечную станцию: ').downcase
    @storage.create_route(first, last)
  end

  def add_carriage
    type = ask('Введите тип вагона: ')
    number = ask('Введите номер вагона: ')
    place = ask('загрузка вагона').to_i
    @storage.create_carriage(number, type, place)
  end

  def set_route_to_train
    train_number = ask('введите номер поезда: ')
    route_name = ask('введите маршрут на который поставить поезд в формате: "город - город2": ')
    @storage.set_route_to_train(route_name, train_number)
  end

  def add_carriage_to_train
    puts 'введите номер поезда: '
    train_number = gets.chomp
    puts 'Введите номер вагона: '
    carriage_number = gets.chomp

    @storage.add_carriage_to_train(carriage_number, train_number)
  end

  def remove_carriage_from_train
    train_number = ask('введите номер поезда: ')
    carriage_number = ask('Введите номер вагона: ')
    @storage.remove_carriage_from_train(train_number, carriage_number)
  end

  def go_to_next_station
    train_number = ask('введите номер поезда: ')
    @storage.go_to_next_station(train_number)
  end

  def go_to_previous_station
    train_number = ask('введите номер поезда: ')
    @storage.go_to_previous_station(train_number)
  end

  def add_station_to_route
    station_name = ask('введите название станции: ')
    route_name = ask('введите маршрут на который добавить станцию ')
    @storage.add_station_to_route(station_name, route_name)
  end

  def remove_station_from_route
    station_name = ask('введите название станции: ')
    route_name = ask('введите маршрут из которого убрать станцию')
    @storage.remove_station_on_route(station_name, route_name)
  end

  def show_station_trains
    name = ask('введите название станции: ')
    @storage.show_station_trains(name)
  end

  def show_train_carriages
    number = ask('введите номер поезда: ')
    @storage.show_train_carriages(number)
  end

  def add_volume_to_carriage
    number = ask('введите номер вагона: ')
    volume = ask('введите объем груза: ').to_i
    @storage.load_to_carriage(number, volume)
  end

  def take_seat_to_carriage
    number = ask('введите номер вагона: ')
    @storage.load_to_carriage(number, 1)
  end

  def show_menu
    @start_menu.each { |key, value| puts "#{key} -> #{value}" }
  end

  def ask(question)
    puts question
    gets.chomp
  end
end
