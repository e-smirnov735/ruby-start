# frozen_string_literal: true

require_relative 'menu_module'
require_relative './../controllers/route_controller'

# Route Menu
class RouteMenu
  include MenuModule

  def initialize
    @controller = RouteController.new
  end

  def menu
    {
      1 => { description: 'Создать маршрут',
             action: -> { create_route } },
      2 => { description: 'Назначить маршрут поезду',
             action: -> { add_station_to_route } },
      0 => { description: 'Вернуться к основному меню' }
    }
  end

  def create_route
    first = ask('Введите первую станцию: ').downcase
    last = ask('Введите конечную станцию: ').downcase
    @controller.create_route(first, last)
  end

  def set_route_to_train
    train_number = ask('введите номер поезда: ')
    route_name = ask('введите маршрут на который поставить поезд в формате: "город - город2": ')
    @controller.set_route_to_train(route_name, train_number)
  end
end
