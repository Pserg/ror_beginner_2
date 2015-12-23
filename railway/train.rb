class Train
  include Manufacturer

  @@trains = []

  class << self
    def all
      @@trains
    end

    def find(number)
      find_train = nil
      @@trains.each do |train|
        find_train = train if train.object_id == number
      end

      if find_train
        find_train
      else
        nil
      end
    end

  end

  def initialize (wagons_amount)
    @wagons_amount = wagons_amount
    @speed = 0
    @@trains << self
  end

  def train_stopped?
    @speed == 0
  end

  def increase_speed
    @speed += 5
  end

  def decrease_speed
    @speed -= 5 unless train_stopped?
  end

  def current_speed
    puts "Текущая скорость поезда #{self.object_id} - #{@speed} "
  end

  def wagons_amount
    @wagons_amount
  end

  def add_wagon(wagon)
    if train_stopped? && type == wagon.type
      @wagons_amount += 1
      puts "К поезду #{self.object_id} добавлен вагон"
    else
      puts 'Невозможно добавить вагоны к движущемуся поезду или тип вагона не соответствует типу поезда'
    end

  end

  def remove_wagon
    if train_stopped? && @wagons_amount > 0
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

    puts "Маршрут поезда #{self.object_id}:
          предыдущая станция - #{previous_station}, текущая станция - #{current_station}, следующая станция - #{next_station}"
  end

  protected

  def current_station
    @route[@current_station].name
  end

  def previous_station
    (@current_station - 1 < 0) ? previous_station = '' : previous_station = @route[@current_station - 1].name
  end

  def next_station
    (@current_station >= @route.size - 1) ? next_station = '' : next_station = @route[@current_station+1].name
  end


end