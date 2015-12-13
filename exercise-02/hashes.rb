# Сделать хеш, содержащий месяцы и количество дней в месяце.
# В цикле выводить те месяцы, у которых количество дней ровно 30
months =
    {yanuary: 31, february: 28, mach: 31, april: 30, may: 31, june: 30, july: 31,
     augost: 31, september: 30, octouber: 31, november: 30, december: 31}
months.each {|month, days| puts month if days == 30}
puts months.inspect

#Заполнить массив числами от 10 до 100 с шагом 5
numbers = []
number = 10
while number <= 100
	numbers << number
	number += 5
end
puts numbers.inspect

#Заполнить массив числами фибоначи до 100
fibonacci = [0,1,1]
x = 0
while x <= 100
	x = fibonacci[-1] + fibonacci[-2]
	fibonacci <<  x if x < 100
end
puts fibonacci.inspect

# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
vowels = ['а','у','э','о','ы','я','ю','е','ё','и']
letters = {}
('а'..'я').to_a.map.with_index { |letter, index| letters[letter.to_s] = index + 1 if vowels.include?(letter) }
puts letters.inspect

# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным
day = 0
month = 0
year = 0
index_number = 0
loop do
	puts 'Задайте дату в формате 11.11.2011 '
	input = gets.chomp.split('.')
  if input.size == 3
		day = input[0].to_i
    month = input[1].to_i - 1
    year = input[2].to_i
    break
  else
		puts 'Вы задали дату в неверном формате'
	end
end
# Високосный год - тот, который кратен 4, но в тоже время не кратен 100.
months = [31,28,31,30,31,30,31,31,30,31,30,31]
months[1] = 29 if year % 4 == 0 && year % 100 != 0
(0...month).each { |i| index_number += months[i] }
puts "Порядковый номер заданной даты - #{index_number += day}"

#