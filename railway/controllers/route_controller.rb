# frozen_string_literal: true

# Route controller
class RouteController
  def initialize
    @storage = STORAGE
  end

  def create_route(first, last)
    raise 'маршрут с таким именем уже существует' if route?(first, last)

    first_station = @storage.find_by_name(first, :stations)
    raise "станция с именем #{first} не найдена" unless first_station

    last_station = @storage.find_by_name(last, :stations)
    raise "станция с именем #{last} не найдена" unless first_station

    route = Route.new(first_station, last_station)
    @storage.routes.push(route)
    puts "Создан маршрут: #{first} - #{last}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def set_route_to_train(route_name, train_number)
    route = @storage.find_by_name(route_name, :routes)
    raise "Маршрут с именем #{route_name} не найден" unless route

    train = find_by_number(train_number, :trains)
    raise "Поезд с номером #{train_number} не найден" unless first_station

    train.route = route
    puts "Маршрут #{route.name} назначен поезду с номером #{train.number}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  private

  def route?(first, last)
    name = "#{first} - #{last}"
    route = @storage.find_by_name(name, :routes)
    !!route
  end
end
