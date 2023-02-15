# frozen_string_literal: true

# class Storage
class Storage
  def initialize
    @store = { trains: [], stations: [], routes: [], carriages: [] }
  end

  def trains
    @store[:trains]
  end

  def stations
    @store[:stations]
  end

  def routes
    @store[:routes]
  end

  def carriages
    @store[:carriages]
  end

  def find_by_number(number, key)
    @store[key].detect { |x| x.number == number }
  end

  def find_by_name(name, key)
    @store[key].detect { |x| x.name == name }
  end
end
