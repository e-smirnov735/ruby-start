module TestData
  def self.load_data(storage)
    st_controller = StationController.new
    st_controller.create_station('msk')
    st_controller.create_station('spb')
    st_controller.create_station('sochi')

    train_controller = TrainController.new
    train_controller.create_train('AA1-FF', 'cargo')
    train_controller.create_train('AA1-DD', 'cargo')
    train_controller.create_train('AS3-WW', 'passenger')
    train_controller.create_train('AS3-DD', 'passenger')

    route_controller = RouteController.new
    route_controller.create_route('msk', 'spb')

    carriage_controller = CarriageController.new

    carriage_controller.create_carriage('1234', 'cargo', 40_000)
    carriage_controller.create_carriage('9999', 'passenger', 120)
    carriage_controller.create_carriage('5555', 'cargo', 30_000)
    carriage_controller.create_carriage('6666', 'passenger', 220)
    carriage_controller.add_carriage_to_train('9999', 'AS3-WW')
    carriage_controller.add_carriage_to_train('1234', 'AA1-FF')
    carriage_controller.add_carriage_to_train('6666', 'AS3-WW')
    carriage_controller.add_carriage_to_train('5555', 'AA1-FF')

    st_controller.add_station_to_route('sochi', 'msk - spb')
    route_controller.set_route_to_train('msk - spb', 'AA1-FF')
    route_controller.set_route_to_train('msk - spb', 'AS3-WW')
    train_controller.go_to_next_station('AA1-FF')
    train_controller.go_to_previous_station('AA1-FF')

    carriage_controller.remove_carriage_from_train('AS3-WW', '1234')
  end
end
