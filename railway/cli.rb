class Cli
  attr_reader :stations, :trains, :help

  def initialize
    @stations = []
    @trains = []
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
        lts (list trains on stations) - вывести список поездов на стации '
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
          self.list
        when 'cs'
          self.create_station
        when 'cpt'
          self.create_passenger_train
        when 'cct'
          self.create_cargo_train
        when 'awtt'
          self.add_wagon_to_train
        when 'rwft'
           self.remove_wagon_from_train
        when 'mvts'
          self.move_train_to_station
        when 'ls'
          self.list_stations
        when 'lts'
          self.list_trains_on_station
        else
          puts 'Вы не задали ни одной допустимой команды или ошиблись при вводе'
      end

    end
  end

  protected

  def list
    puts 'Заданы следующие поезда и станции:'
    puts 'Поезда:'
    trains.each_with_index { |train, index| puts "Индекс поезда - #{index}, номер поезда - #{train.object_id}, тип поезда - #{train.type},  количество вагонов - #{train.wagons_amount}"}
    puts 'Станции:'
    stations.each_with_index {|station, index| puts "Индекс станции - #{index}, название станции - #{station.name}" }
  end

  def create_station
    puts 'Задайте название станции '
    name = gets.chomp
    stations << RailwayStation.new(name)
    puts stations.inspect
  end

  def create_passenger_train
    puts 'Задайте количество вагонов'
    wagons = gets.to_i
    trains << PassengerTrain.new(wagons)
  end

  def create_cargo_train
    puts 'Задайте количество вагонов'
    wagons = gets.to_i
    trains << CargoTrain.new(wagons)
  end

  def add_wagon_to_train
    puts 'Задайте индекс поезда, к которому неоходимо добавить вагон '
    train_index = gets.to_i
    train = trains[train_index]
    if train.type == :passenger
      train.add_wagon(PassengerWagon.new)
    else
      train.add_wagon(CargoWagon.new)
    end
  end

  def remove_wagon_from_train
    puts 'Задайте индекс поезда, от которого неоходимо отцепить вагон '
    train_index = gets.to_i
    trains[train_index].remove_wagon
  end

  def move_train_to_station
    puts 'Задайте через запятую индекс поезда и индекс станции '
    train_index, station_index = gets.split(',')
    station = stations[station_index.to_i]
    train = trains[train_index.to_i]
    station.accept_train(train)
  end

  def list_stations
    puts 'Станции:'
    stations.each_with_index {|station, index| puts "Индекс станции - #{index}, название станции - #{station.name}" }
  end

  def list_trains_on_station
    puts 'Задайте индекс станции '
    station_index = gets.to_i
    stations[station_index].list_trains
    puts ''
  end


end
