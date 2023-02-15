# frozen_string_literal: true

require_relative 'menu_starter_module'
require_relative 'train_menu'
require_relative 'station_menu'
require_relative 'route_menu'
require_relative 'carriage_menu'

# Main Menu
class MainMenu
  include MenuStarter

  def initialize
    @trains_menu = TrainMenu.new
    @stations_menu = StationMenu.new
    @routes_menu = RouteMenu.new
    @carriages_menu = CarriageMenu.new
  end

  def menu
    {
      1 => { description: 'Операции с поездами',
             action: -> { @trains_menu.start } },
      2 => { description: 'Операции со станциями',
             action: -> { @stations_menu.start } },
      3 => { description: 'Операции с маршрутами',
             action: -> { @routes_menu.start } },
      4 => { description: 'Операции с вагонами',
             action: -> { @carriages_menu.start } },
      5 => { description: 'Вывод информации',
             action: -> { STORAGE.show_info } },
      0 => { description: 'Выход' }
    }
  end
end
