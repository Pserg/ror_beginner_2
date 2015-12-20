require_relative('railway_station')
require_relative('route')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('wagon')
require_relative('passenger_wagon')
require_relative('cargo_wagon')

stations = []
trains = []

help = 'Вы можете использовать следующие команды для управления программой:
        help - вывод текущей справки, exit - выход из программы,
        list - вывести все станции и поезда,
        cs (create station) - создать новую станцию,
        cpt (create passenger train) -  создать пассажирский поезд,
        cct (create cargo train) - создать товарный поезд,
        awtt (add wagon to train) - добавить вагон к пезду,
        rwft (remove wagon from train) - отцепить вагон от поезда,
        mvts (move train to station) - переместить поезд на станцию,
        ls (list stations) - вывести список всех станций,
        lts (list trains on stations) - вывести список поездов на стации '

puts help

loop do
  puts 'Введтие команду: '
  input = gets.chomp

  case input
    when 'exit'
      exit
    when 'help'
      puts help
    when 'list'
      puts 'Заданы следующие поезда и станции:'
      puts 'Поезда:'
      trains.each_with_index { |train, index| puts "Индекс поезда - #{index}, номер поезда - #{train.object_id}, тип поезда - #{train.type},  количество вагонов - #{train.wagons_amount}"}
      puts 'Станции:'
      stations.each_with_index {|station, index| puts "Индекс станции - #{index}, название станции - #{station.name}" }
    when 'cs'
      puts 'Задайте название станции '
      name = gets.chomp
      stations << RailwayStation.new(name)
      puts stations.inspect
    when 'cpt'
      puts 'Задайте количество вагонов'
      wagons = gets.to_i
      trains << PassengerTrain.new(wagons)
    when 'cct'
      puts 'Задайте количество вагонов'
      wagons = gets.to_i
      trains << CargoTrain.new(wagons)
    when 'awtt'
      puts 'Задайте индекс поезда, к которому неоходимо добавить вагон '
      train_index = gets.to_i
      train = trains[train_index]
      if train.type == :passenger
        train.add_wagon(PassengerWagon.new)
      else
        train.add_wagon(CargoWagon.new)
      end
    when 'rwft'
      puts 'Задайте индекс поезда, от которого неоходимо отцепить вагон '
      train_index = gets.to_i
      trains[train_index].remove_wagon
    when 'mvts'
      puts 'Задайте через запятую индекс поезда и индекс станции '
      train_index, station_index = gets.split(',')
      station = stations[station_index.to_i]
      train = trains[train_index.to_i]
      station.accept_train(train)
    when 'ls'
      puts 'Станции:'
      stations.each_with_index {|station, index| puts "Индекс станции - #{index}, название станции - #{station.name}" }
    when 'lts'
      puts 'Задайте индекс станции '
      station_index = gets.to_i
      stations[station_index].list_trains
      puts ''
    else
      puts 'Вы не задали ни одной допустимой команды или ошиблись при вводе'
  end

end



