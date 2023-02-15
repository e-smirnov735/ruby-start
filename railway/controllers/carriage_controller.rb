# frozen_string_literal: true

# Carriage controller
class CarriageController
  def initialize
    @storage = STORAGE
  end

  def create_carriage(number, type, place)
    raise 'Неправильный тип вагона' unless %w[cargo passenger].include?(type)
    raise "Вагон с номером #{number} уже существует" if storage.find_by_number(number, :carriages)

    carriage = CargoCarriage.new(number, place) if type == 'cargo'
    carriage = PassengerCarriage.new(number, place) if type == 'passenger'

    @storage.carriages.push(carriage)
    puts "Создан #{carriage}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def add_carriage_to_train(carriage_number, train_number)
    carriage = @storage.find_by_number(carriage_number, :carriages)
    raise "Вагон с номером #{carriage_number} не найден" unless carriage

    train = @storage.find_by_number(train_number, :trains)
    raise "Поезд с номером #{train_number} не найден" unless train
    raise STORAGE_ERRORS[:wrong_carriage_type] unless carriage.type == train.type

    train.add_carriage(carriage)
    carriage.is_attached = true
    puts "вагон с номером #{carriage_number} добавлен к поезду с номером #{train_number}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def remove_carriage_from_train(train_number, carriage_number)
    carriage = @storage.find_by_number(carriage_number, :carriages)
    raise "Вагон с номером #{carriage_number} не найден" unless carriage

    train = @storage.find_by_number(train_number, :trains)
    raise "Поезд с номером #{train_number} не найден" unless train

    train.remove_carriage(carriage)
    carriage.is_attached = false
    puts "вагон с номером #{carriage_number} отцеплен от поезда с номером #{train_number}"
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end

  def load_to_carriage(number, volume)
    carriage = @storage.find_by_number(number, :carriages)
    raise "Вагон с номером #{number} не найден" unless carriage

    carriage.type == 'cargo' ? carriage.take_place(volume) : carriage.take_place
  rescue RuntimeError => e
    puts "#{e.message}. попробуйте еще раз"
  end
end
