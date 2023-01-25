#4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

result = Hash.new(0)
exp = "aeiouy"

("a".."z").each_with_index do |letter, i|
  result[letter] = i + 1 if exp.include?(letter)
end

print result
