# frozen_string_literal: true

require_relative 'menu_module'
require_relative './../controller/carriage_controller'

# Train menu
class CarriageMenu
  include MenuModule

  def initialize
    @controller = CarriageController.new
  end

  def menu
    {
      1 => { description: 'Создать вагон', action: -> { add_train } },
      2 => { description: 'Прицепить вагон к поезду', action: -> { add_carriage_to_train } },
      3 => { description: 'Отцепить вагон от поезда', action: -> { remove_carriage_from_train } },
      4 => { description: 'Загрузить грузовой вагон', action: -> { add_volume_to_carriage } },
      5 => { description: 'Занять место в пассажирском вагоне', action: -> { take_seat_to_carriage } },
      0 => { description: 'Вернуться к основному меню' }
    }
  end

  def create_carriage
    type = ask('Введите тип вагона: ')
    number = ask('Введите номер вагона: ')
    place = ask('загрузка вагона').to_i

    @controller.create_carriage(number, type, place)
  end

  def add_carriage_to_train
    puts 'введите номер поезда: '
    train_number = gets.chomp
    puts 'Введите номер вагона: '
    carriage_number = gets.chomp

    @controller.add_carriage_to_train(carriage_number, train_number)
  end

  def remove_carriage_from_train
    train_number = ask('введите номер поезда: ')
    carriage_number = ask('Введите номер вагона: ')

    @controller.remove_carriage_from_train(train_number, carriage_number)
  end

  def add_volume_to_carriage
    number = ask('введите номер вагона: ')
    volume = ask('введите объем груза: ').to_i

    @controller.load_to_carriage(number, volume)
  end

  def take_seat_to_carriage
    number = ask('введите номер вагона: ')

    @controller.load_to_carriage(number, 1)
  end
end
