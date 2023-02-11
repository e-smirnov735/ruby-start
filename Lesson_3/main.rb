# frozen_string_literal: true

require_relative 'storage'
require_relative 'app'
require_relative 'test'

def main
  storage = Storage.new
  Test.load_data(storage)
  app = App.new(storage)
  app.start
end

main
