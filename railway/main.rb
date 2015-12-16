class RailwayStation

  attr_accessor :name

  def initialize (name)
    @name = name
    @trains = []
  end

  def accept_train (train)
    @trains << train
  end

  def list_trains
    puts "Список поездов на станции #{@name}:   "
    @trains.each {|train| print "\nПоезд №#{train.object_id}."}
  end

  def list_trains_by_type
    puts "Список пассажирских поездов на станции #{@name}:   "
    @trains.each {|train| print "\nПоезд №#{train.object_id}." if train.type == 'passenger'}
    puts "Список грузовых поездов на станции #{@name}:   "
    @trains.each {|train| print "\nПоезд №#{train.object_id}." if train.type == 'cargo'}
  end

  def send_train(train)
    @trains.delete(train)
    puts "Поезд №#{train.object_id} отправился со станции #{@name}"
  end

end

class Route
  attr_accessor :route
  def initialize (start_station,end_station)
    @route = [start_station,end_station]
  end

  def add_station(station)
    @route.insert(-2,station)
    puts "Станция #{station.name} добавлена в маршрут"
  end

  def remove_station(station)
    @route.delete(station)
    puts "Станция #{station.name} удалена из маршрута"
  end

  def list_route
    puts 'Список станций маршрута: '
    @route.each {|station| print "#{station.name} -> "}
  end

end

class Train

  def initialize (train_type,wagons_amount)
    @train_type = train_type
    @wagons_amount = wagons_amount
    @speed = 0
  end

  def increase_speed
    @speed += 5
  end

  def decrease_speed
    @speed -= 5 if @speed != 0
  end

  def current_speed
    puts "Текущая скорость поезда #{self.object_id} - #{@speed} "
  end

  def wagons_amount
    puts "Количество вагонов поезда #{self.object_id} - #{@wagons_amount}"
  end

  def add_wagon
    if @speed == 0
      @wagons_amount += 1
      puts "К поезду #{self.object_id} добавлен вагон"
    else
      puts 'Невозможно добавить вагоны к движущемуся поезду'
    end

  end

  def remove_wagon
    if @speed == 0 && @wagons_amount > 0
      @wagons_amount -= 1
      puts "От поезда #{self.object_id} отцеплен вагон"
    else
      puts 'Операция невозможна. Поезд движется, либо у поезда больше нет вагонов'
    end
  end

  def add_route (route)
    @route = route.route
    @current_station = 0
  end

  def move_next_station
    @current_station += 1 if @current_station < @route.size - 1
  end

  def list_route
    (@current_station - 1 < 0) ? previous_station = '' : previous_station = @route[@current_station - 1].name
    (@current_station >= @route.size - 1) ? next_station = '' : next_station = @route[@current_station+1].name
    puts "Маршрут поезда #{self.object_id}: предыдущая станция - #{previous_station},
      текущая станция - #{@route[@current_station].name},
      следующая станция - #{next_station}"
  end

end



