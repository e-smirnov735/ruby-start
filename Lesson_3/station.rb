# frozen_string_literal: true

require_relative 'train'

# class Station
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
