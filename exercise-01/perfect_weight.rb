# Идеальный вес. Программа запрашивает имя и рост и выводит идеальный вес по формуле <рост> - 110, после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"
puts 'Введите ваше имя: '
name = gets.chomp
puts 'Введите ваш рост: '
height = gets.chomp.to_i
weight = height - 110
if weight <= 0 
	puts "#{name}, ваш вес уже оптимальный"
else 
	puts "#{name}, ваш идеальный вес - #{weight}"
end	
