# frozen_string_literal: true
require_relative 'train'

class Station
  attr_reader :train_list

  def initialize(name)
    @name = name
    @train_list = []
  end

  def show_trains_by_type(type)
    @train_list.select { |x| x.type == type }
  end

  def add_train(train)
    @train_list.push(train) if train.is_a?(Train)
  end

  def remove_train(train)
    @train_list.delete(train) if train.is_a?(Train)
  end
end
