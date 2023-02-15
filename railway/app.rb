# frozen_string_literal: true

require_relative 'storage'
require_relative 'menu/main_menu'
require_relative 'test'

STORAGE = Storage.new

def main
  TestData.load_data(STORAGE)
  main_menu = MainMenu.new

  main_menu.start
end

main
