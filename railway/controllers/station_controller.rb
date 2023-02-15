# frozen_string_literal: true

# Station controller
class StationController
  def initialize
    @storage = STORAGE
  end

  def create_station(name)
    raise 'станция с таким именем уже существует' if @storage.get_by_name(name, :stations)

    station = Station.new(name)
    @storage.stations.push(station)
    puts "create #{station}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def add_station_to_route(station_name, route_name)
    station = @storage.find_by_name(station_name, :stations)
    raise 'станция с таким именем не найдена' unless station

    route = find_by_name(route_name, :routes)
    raise 'маршрут с таким именем не найден' unless route

    route.add_station(station)
    puts "Станция: #{station.name} добавлена к маршруту: #{route.name}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def remove_station_on_route(station_name, route_name)
    station = @storage.find_by_name(station_name, :stations)
    raise 'станция с таким именем не найдена' unless station

    route = find_by_name(route_name, :routes)
    raise 'маршрут с таким именем не найден' unless route

    route.remove_station(station)
    puts "Станция: #{station.name} удалена из маршрута: #{route.name}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end
end
