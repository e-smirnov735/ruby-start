# frozen_string_literal: true

require_relative 'train'
require_relative 'instance_counter'

# class Station
class Station
  include InstanceCounter

  @@station_instances = []
  attr_reader :trains, :name

  init_counter

  def initialize(name)
    @name = name
    @trains = []
    @@station_instances.push(self)
    register_instance
  end

  def self.all
    @@station_instances
  end

  def show_trains_by_type(type)
    @trains.select { |x| x.type == type }
  end

  def add_train(train)
    @trains.push(train) if train.is_a?(Train)
  end

  def remove_train(train)
    @trains.delete(train) if train.is_a?(Train)
  end

  def to_s
    "Станция: #{@name}\tколичество поездов: #{trains.size} (#{trains.map(&:number).join(',')})"
  end
end
