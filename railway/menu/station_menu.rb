# frozen_string_literal: true

require_relative 'menu_starter_module'
require_relative './../controllers/station_controller'

# Station Menu
class StationMenu
  include MenuStarter

  def initialize
    @controller = StationController.new
  end

  def menu
    {
      1 => { description: 'создать станцию',
             action: -> { add_station } },
      2 => { description: 'Добавить станцию в маршрут',
             action: -> { add_station_to_route } },
      3 => { description: 'Убрать станцию из маршрута',
             action: -> { remove_station_from_route } },
      0 => { description: "Вернуться к основному меню\n" }
    }
  end

  def add_station
    name = ask('Введите название станции:')
    @controller.create_station(name)
  end

  def add_station_to_route
    station_name = ask('введите название станции: ')
    route_name = ask('введите маршрут на который добавить станцию ')
    @controller.add_station_to_route(station_name, route_name)
  end

  def remove_station_from_route
    station_name = ask('введите название станции: ')
    route_name = ask('введите маршрут из которого убрать станцию')
    @controller.remove_station_on_route(station_name, route_name)
  end

  def show_station_trains
    name = ask('введите название станции: ')
    @controller.show_station_trains(name)
  end
end
