days_of_month = {
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31,
  }

print "введите число: "
day = gets.chomp.to_i
print "введите месяц: "
month = gets.chomp.to_i
print "введите год: "
year = gets.chomp.to_i

result = 0

# является ли высокосным годом
is_leap = (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)

# добавляем дни за полностью прошедшие месяцы
(1...month).each { |m| result += days_of_month[m] }  

# добавляем дни текущего месяцы
result += day
#  поправка на высокосный год
result += 1 if is_leap && month > 2

puts result

