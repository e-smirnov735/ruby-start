print "Введите коэффициент 'a': "
a = gets.to_f
print "Введите коэффициент 'a': "
b = gets.to_f
print "Введите коэффициент 'a': "
c = gets.to_f

d = b**2 - 4 * a * c

if d > 0
    x1 = (-b + Math.sqrt(d)) / (2 * a)
    x2 = (-b - Math.sqrt(d)) / (2 * a)
    puts "в уравнении 2 корня: #{x1}, #{x2}"
elsif d == 0
    x = -b / (2 * a)
    puts "в уравнении 1 корень: #{x}"
else
    puts "корней нет"
end