# frozen_string_literal: true

require_relative 'storage'
require_relative 'menu/main_menu'

STORAGE = Storage.new

def main
  main_menu = MainMenu.new

  main_menu.start
end

main
