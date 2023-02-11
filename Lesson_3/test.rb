module Test
  def self.load_data(storage)
    storage.create_station('msk')
    storage.create_station('spb')
    storage.create_station('sochi')
    storage.create_train('AA1-FF', 'cargo')
    storage.create_train('AA1-DD', 'cargo')
    storage.create_train('AS3-WW', 'passenger')
    storage.create_train('AS3-DD', 'passenger')

    storage.create_route('msk', 'spb')

    storage.create_carriage('1234', 'cargo', 40_000)
    storage.create_carriage('9999', 'passenger', 120)
    storage.create_carriage('5555', 'cargo', 30_000)
    storage.create_carriage('6666', 'passenger', 220)
    storage.add_carriage_to_train('9999', 'AS3-WW')
    storage.add_carriage_to_train('1234', 'AA1-FF')
    storage.add_carriage_to_train('6666', 'AS3-WW')
    storage.add_carriage_to_train('5555', 'AA1-FF')

    storage.add_station_to_route('sochi', 'msk - spb')
    storage.set_route_to_train('msk - spb', 'AA1-FF')
    storage.set_route_to_train('msk - spb', 'AS3-WW')
    storage.go_to_next_station('AA1-FF')
    storage.go_to_previous_station('AA1-FF')

    storage.remove_carriage_from_train('AS3-WW', '1234')

    puts('----test---')
    puts "Количество Станций: #{Station.instances}"
    puts "Количество маршрутов: #{Route.instances}"
    puts "Количество поездов: #{Train.instances}"
    puts "Количество вагонов: #{storage.carriages.size}"
    puts('---test---')
  end

  def print
    puts 'print Test'
  end
end
