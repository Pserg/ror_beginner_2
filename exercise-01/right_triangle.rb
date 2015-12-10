# Прямоугольный треугольник
puts 'Задайте стороны треугольника через запятую, пример 10,15,14.5 '
input = gets.chomp.split(',').sort
if input.length != 3 
	puts 'Вы задали неверное количество аргументов'
	exit
end	
cathetus_1 = input[0].to_f
cathetus_2 = input[1].to_f
hypotenuse = input[2].to_f
def right_triangle? (cathetus_1, cathetus_2, hypotenuse) 
	if hypotenuse**2 == cathetus_1**2 + cathetus_2**2
		return true
	end	
end	
if cathetus_1 == hypotenuse && cathetus_1 == cathetus_2
	puts 'Треугольник равносторонний'
elsif cathetus_1 == hypotenuse || cathetus_1 == cathetus_2 || cathetus_2 == hypotenuse
	if right_triangle?(cathetus_1,cathetus_2,hypotenuse)
    puts 'Треугольник прямоугольный и равнобедренный'
  else
  	puts 'Треугольник равнобедренный'
  end
else
	if right_triangle?(cathetus_1,cathetus_2,hypotenuse)
    puts 'Треугольник прямоугольный'
  else
    puts 'Обычный треугольник'
  end

end	


