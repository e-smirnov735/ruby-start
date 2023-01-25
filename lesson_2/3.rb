#3. Заполнить массив числами фибоначчи до 100
arr = [0]

prev = 0
current = 1

while current <= 100
  arr.push(current)
  prev, current = current, prev + current
end

print arr 
