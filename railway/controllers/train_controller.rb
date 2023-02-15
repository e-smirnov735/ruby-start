# frozen_string_literal: true

require_relative './../models/cargo_train'
require_relative './../models/passenger_train'

# Train controller
class TrainController
  def initialize
    @storage = STORAGE
  end

  def create_train(number, type)
    raise 'Неправильный тип вагона' unless %w[cargo passenger].include?(type)
    raise "Поезда с номером  #{number} уже существует" if @storage.find_by_number(
      number, :trains
    )

    train = CargoTrain.new(number, type) if type == 'cargo'
    train = PassengerTrain.new(number, type) if type == 'passenger'

    @storage.trains.push(train)
    puts "Создан #{train}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def go_to_next_station(number)
    train = @storage.find_by_number(number, :trains)
    raise "Поезда с номером  #{number} не найден" unless train

    train.go_to_next_station
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def go_to_previous_station(number)
    train = @storage.find_by_number(number, :trains)
    raise "Поезда с номером  #{number} не найден" unless train

    train.go_to_previous_station
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def show_train_carriages(number)
    train = @storage.find_by_number(number, :trains)
    raise "Поезда с номером  #{number} не найден" unless train

    train.iteration { |carriages| puts carriages }
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end
end
