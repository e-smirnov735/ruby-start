=begin
Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), равнобедренным (т.е. у него равны любые 2 стороны)  или равносторонним (все 3 стороны равны) и выводит результат на экран. Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.  
=end

print "Введите длину первой стороны: "
a = gets.to_i
print "Введите длину второй стороны: "
b = gets.to_i
print "Введите длину третьей стороны: "
c = gets.to_i

if a == b && b == c
    puts "Треугольник равнобедренный и равносторонний"
elsif a == b || b == c || a == c
    puts "Треугольник равнобедренный"
elsif a**2 + b**2 == c**2 || b**2 + c**2 == a**2 || a**2 + c**2 == b**2
    puts "треугольник прямоугольный"
else 
    puts "треугольник разносторонний"
end
