# frozen_string_literal: true

require_relative 'menu_starter_module'
require_relative './../controllers/train_controller'

# Train menu
class TrainMenu
  include MenuStarter

  def initialize
    @controller = TrainController.new
  end

  def menu
    {
      1 => { description: 'создать поезд',
             action: -> { add_train } },
      2 => { description: 'перместить поезд на следующую станцию',
             action: -> { go_to_next_station } },
      3 => { description: 'переместить поезд на предыдущую станцию',
             action: -> { go_to_previous_station } },
      0 => { description: 'Вернуться к основному меню' }
    }
  end

  def add_train
    train_number = ask('Введите номер поезда: (формат: ASB-AV | 123-AS)')
    train_type = ask('Введите тип поезда (cargo / passenger):')
    @controller.create_train(train_number, train_type)
  end

  def go_to_next_station
    train_number = ask('введите номер поезда: ')
    @controller.go_to_next_station(train_number)
  end

  def go_to_previous_station
    train_number = ask('введите номер поезда: ')
    @controller.go_to_previous_station(train_number)
  end

  def show_train_carriages
    number = ask('введите номер поезда: ')
    @storage.show_train_carriages(number)
  end
end
