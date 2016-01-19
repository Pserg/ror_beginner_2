class Train
  include Manufacturer

  @@trains = {}

  class << self
    def all
      @@trains
    end

    def find(number)
      @@trains[number]
    end
end

  attr_reader :wagons_amount, :number

  TRAIN_NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  def initialize (number, wagons_amount)
    @number = number
    @wagons_amount = wagons_amount
    @speed = 0
    @@trains[self.object_id] = self
    validate!
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

  def add_wagon(wagon)
    if train_stopped? && type == wagon.type
      @wagons_amount += 1
      puts "К поезду #{self.object_id} добавлен вагон"
    else
      raise ArgumentError, 'Невозможно добавить вагоны к движущемуся поезду или тип вагона не соответствует типу поезда'
    end

  end

  def remove_wagon
    if train_stopped? && @wagons_amount > 0
      @wagons_amount -= 1
      puts "От поезда #{self.object_id} отцеплен вагон"
    else
      Raise ArgumentError, 'Операция невозможна. Поезд движется, либо у поезда больше нет вагонов'
    end
  end

  def add_route (route)
    raise ArgumentError, 'Ошибка. Невозможно добавить маршрут, проверьте тип маршрута' if route.class != Route
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  attr_writer :wagons_amount

  def current_station
    @route[@current_station].name
  end

  def previous_station
    (@current_station - 1 < 0) ? previous_station = '' : previous_station = @route[@current_station - 1].name
  end

  def next_station
    (@current_station >= @route.size - 1) ? next_station = '' : next_station = @route[@current_station+1].name
  end

  def validate!
    raise ArgumentError, 'Wagons amount must be positive integer' if wagons_amount < 0 || wagons_amount.integer? == false
    raise ArgumentError, 'Invalid train number' if number !~ TRAIN_NUMBER_FORMAT
    raise ArgumentError, 'An number already exist' if Train.find(number)
    true
  end




end