# frozen_string_literal: true

# Menu starter module
module MenuStarter
  def start
    loop do
      show_menu
      choice = gets.chomp.to_i
      category = menu[choice]
      puts category[:description]

      break if choice.zero?

      category[:action].call
    end
  end

  def show_menu
    menu.each { |key, value| puts "#{key} -> #{value[:description]}\n" }
  end

  protected

  def ask(question)
    puts question
    gets.chomp
  end
end
