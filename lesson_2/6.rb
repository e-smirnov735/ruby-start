products = Hash.new

loop do
  print "введите  наименование товара: "
  product = gets.chomp

  break if product == "стоп"

  print "введите цену товара: "
  price = gets.chomp.to_f
  print "введите количество: "
  count = gets.chomp.to_f
  
  products[product] = {price: price, count: count}
end

def show_product_info(products)
  puts "Список покупок"
  products.each do |key, value|
    price = value[:price]
    count = value[:count]
    total = price * count
    puts "товар: #{key}\tцена: #{price}\tкол-во: #{count}\tсумма: #{total}"
  end
end

def calculate_final_amount(products)
  total = 0
  products.each do |key, value|
    total += value[:price] * value[:count]
  end

  return total

end

show_product_info(products)
puts "Всего покупок на сумму #{calculate_final_amount(products)}"

