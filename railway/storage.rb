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

  def show_info
    puts '-' * 10
    show_data('trains', trains)
    show_data('stations', stations)
    show_data('routes', routes)
    show_data('carriages', carriages)
    puts '-' * 10
  end

  protected

  def show_data(name, arr)
    puts "#{name} list: "
    if arr.empty?
      puts "\tсписок пуст"
      return
    end

    arr.each { |item| puts "\t#{item}" }
  end
end
