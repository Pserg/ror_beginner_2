require_relative('instance_counter')
require_relative('manufacturer')
require_relative('accessor')
require_relative('validation')
require_relative('railway_station')
require_relative('route')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('wagon')
require_relative('passenger_wagon')
require_relative('cargo_wagon')
require_relative('cli')

#user_interface = Cli.new
#user_interface.start


w1 = Wagon.new
w1.a = 1
w1.b = 2
w1.a = 5
w1.b = 10
puts w1.a_history.inspect
puts w1.b_history.inspect
#w1.c_history