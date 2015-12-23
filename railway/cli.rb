class Cli
  attr_reader :help

  def initialize
    @help = 'Вы можете использовать следующие команды для управления программой:
        help - вывод текущей справки, exit - выход из программы,
        list - вывести все станции и поезда,
        cs (create station) - создать новую станцию,
        cpt (create passenger train) -  создать пассажирский поезд,
        cct (create cargo train) - создать товарный поезд,
        awtt (add wagon to train) - добавить вагон к пезду,
        rwft (remove wagon from train) - отцепить вагон от поезда,
        mvts (move train to station) - переместить поезд на станцию,
        ls (list stations) - вывести список всех станций,
        lts (list trains on stations) - вывести список поездов на стации
        ft (find train) - найти поезд по номеру'

    puts help
  end

  def start
    loop do
      puts 'Введтие команду: '
      input = gets.chomp

      case input
        when 'exit'
          exit
        when 'help'
          puts help
        when 'list'
          list
        when 'cs'
          create_station
        when 'cpt'
          create_passenger_train
        when 'cct'
          create_cargo_train
        when 'awtt'
          add_wagon_to_train
        when 'rwft'
          remove_wagon_from_train
        when 'mvts'
          move_train_to_station
        when 'ls'
          list_stations
        when 'lts'
          list_trains_on_station
        when 'ft'
          find_train
        else
          puts 'Вы не задали ни одной допустимой команды или ошиблись при вводе'
      end

    end
  end

  protected

  def list
    puts 'Заданы следующие поезда и станции:'
    puts 'Поезда: '
    Train.all.each_with_index { |train, index| puts "Индекс поезда - #{index}, номер поезда - #{train.object_id}, тип поезда - #{train.type},  количество вагонов - #{train.wagons_amount}"}
    list_stations
    puts
  end

  def create_station
    puts 'Задайте название станции '
    name = gets.chomp
    RailwayStation.new(name)
  end

  def create_passenger_train
    puts 'Задайте количество вагонов'
    wagons = gets.to_i
    PassengerTrain.new(wagons)
  end

  def create_cargo_train
    puts 'Задайте количество вагонов'
    wagons = gets.to_i
    CargoTrain.new(wagons)
  end

  def add_wagon_to_train
    puts 'Задайте индекс поезда, к которому неоходимо добавить вагон '
    train_index = gets.to_i
    train = Train.all[train_index]
    if train.type == :passenger
      train.add_wagon(PassengerWagon.new)
    else
      train.add_wagon(CargoWagon.new)
    end
  end

  def remove_wagon_from_train
    puts 'Задайте индекс поезда, от которого неоходимо отцепить вагон '
    train_index = gets.to_i
    Train.all[train_index].remove_wagon
  end

  def move_train_to_station
    puts 'Задайте через запятую индекс поезда и индекс станции '
    train_index, station_index = gets.split(',')
    station = RailwayStation.all[station_index.to_i]
    train = Train.all[train_index.to_i]
    station.accept_train(train)
  end

  def list_stations
    puts 'Станции:'
    RailwayStation.all.each_with_index {|station, index| print "Индекс: #{index}, #{station.name}. " }
  end

  def list_trains_on_station
    puts 'Задайте индекс станции '
    station_index = gets.to_i
    RailwayStation.all[station_index].list_trains
    puts ''
  end

  def find_train
    puts 'Задайте номер поезда '
    number = gets.to_i
    if Train.find(number)
      puts 'Найден поезд с таким номером'
    else
      puts 'Поезд с таким номером не найден'
    end
  end


end
