print "Назовите ваше имя: "
name = gets.chomp
print "Укажите свой рост в см.: "
weight = gets.chomp.to_i
result = ((weight - 110) * 1.15).round(1)

if result < 0
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, идеальный вес для Вас-  #{result} кг."
end