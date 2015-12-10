# Квадратное уравнение
puts 'Введите через запятую коэффициенты квадратного уравнения '
input = gets.chomp.split(',')
if input.length != 3
  puts 'Вы ввели неверное количество аргументов'
  exit
end
a = input[0].to_f
b = input[1].to_f
c = input[2].to_f
puts "Уравнение имеет вид: #{a}x2 + #{b}x + #{c} = 0"

d = b**2 - 4*a*c

if d < 0
  puts 'Корней нет!'
elsif d == 0
  x = (-b + Math.sqrt(d)) / 2*a
  puts "Уравнение имеет один корень, x1 = #{x}"
else
  x1 = (-b + Math.sqrt(d)) / 2*a
  x2 = (-b - Math.sqrt(d)) / 2*a
  puts "Уравнение имеет два корня, x1 = #{x1}, x2 = #{x2}"
end