# Сумма покупок
basket = {}
loop do
  puts 'Введетие наименование товара или stop для прекращения покупок'
  product = gets.chomp
  if product == 'stop'
  break
  else
    puts 'Введите цену за еденицу товара '
    price = gets.chomp.to_f
    puts 'Задайте количество товара '
    amount = gets.chomp.to_i
  end
  basket[product] = {}
  basket[product][:price] = price
  basket[product][:amount] = amount
end

puts basket.inspect
total_price = 0
basket.each do |product, hash|
  puts "Товар - #{product}, общая стоимость - #{hash[:price] * hash[:amount]}"
  total_price +=  hash[:price] * hash[:amount]
end
puts "Общая стоимость покупок - #{total_price}"
