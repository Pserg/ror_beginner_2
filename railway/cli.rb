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
        lts (list trains on stations) - вывести список поездов на стации,
        ls_all - Вывести поезда на всех станциях,
        ft (find train) - найти поезд по номеру,
        ls_w (list wagons) - вывести вагоны у поезда,
        tp (take place) - занять место в вагона/загрузить вагон,
        '

    puts help
  end

  def start
    loop do
      puts 'Введтие команду: '
      input = gets.chomp.to_sym

      actions = { exit: -> { abort 'Good bye!' }, help: -> { puts help },
                  list: -> { list }, cs: -> { create_station },
                  cpt: -> { create_passenger_train },
                  cct: -> { create_cargo_train }, awtt: -> { add_wagon_to_train },
                  rwfr: -> { remove_wagon_from_train }, mvts: -> { move_train_to_station },
                  ls: -> { list_stations }, lts: -> { list_trains_on_station },
                  fr: -> { find_train }, ls_all: -> { list_trains_on_all_stations },
                  ls_w: -> { list_wagons }, tp: -> { take_place } }

      if actions.key?(input)
        actions[input].call
      else
        puts 'Вы не задали ни одной допустимой команды или ошиблись при вводе'
      end
    end

  rescue ArgumentError => e
    puts e
    retry
  end

  protected

  def list
    puts 'Заданы следующие поезда и станции:'
    puts 'Поезда: '
    Train.all.each { |_index, train| puts "Номер поезда - #{train.number}, тип поезда - #{train.type},  количество вагонов - #{train.wagons.count}" }
    list_stations
    puts
  end

  def create_station
    puts 'Задайте название станции '
    name = gets.chomp
    RailwayStation.new(name)
  end

  def create_passenger_train
    puts 'Задайте номер поезда и количество вагонов'
    number = gets.chomp
    wagons = gets.to_i
    PassengerTrain.new(number, wagons)
  end

  def create_cargo_train
    puts 'Задайте номер поезда и количество вагонов'
    number = gets.chomp
    wagons = gets.to_i
    CargoTrain.new(number, wagons)
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
    puts 'Задайте через запятую номер поезда и индекс станции '
    train_number, station_index = gets.split(',')
    station = RailwayStation.all[station_index.to_i]
    train = Train.all[train_number]
    station.accept_train(train)
  end

  def list_stations
    puts 'Станции:'
    RailwayStation.all.each_with_index { |station, index| print "Индекс: #{index}, #{station.name}. " }
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

  def list_trains_on_all_stations
    RailwayStation.all.each do |station|
      puts station.name
      station.trains.each do |train|
        puts train.info
      end
    end
  end

  def list_wagons
    puts 'Введите номер поезда в формате 111-aa'
    train_number = gets.chomp
    is_train_number!(train_number)
    puts Train.all[train_number].list_wagons
  end

  def take_place
    puts 'Задайте номер поезда'
    train_number = gets.chomp
    is_train_number!(train_number)
    train = Train.find(train_number)
    puts train.list_wagons
    puts 'Введите номер вагона'
    wagon_number = gets.chomp.to_i
    if train.type == :passenger
      train.wagons[wagon_number].take_place
      puts 'Место в вагоне успешно занято'
    else
      puts 'Задайте количество объема'
      volume = gets.chomp.to_i
      train.wagons[wagon_number].take_volume(volume)
      puts 'Объем вагона успешно занят'
    end
  end

  def is_train_number!(train_number)
    fail ArgumentError 'Поезд с таким номером не найден' if Train.all[train_number].nil?
  end
end
