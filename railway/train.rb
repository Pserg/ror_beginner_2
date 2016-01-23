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

  attr_reader :wagons_amount, :number, :wagons

  TRAIN_NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  def initialize (number, wagons_amount)
    @number = number
    @wagons_amount = wagons_amount
    @speed = 0
    validate!
    @@trains[number] = self
    @wagons = []

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
    raise ArgumentError, 'Невозможно добавить вагоны к движущемуся поезду или тип вагона не соответствует типу поезда' if train_stopped? == false || type != wagon.type
    @wagons << wagon
  end

  def remove_wagon
    Raise ArgumentError, 'Операция невозможна. Поезд движется, либо у поезда больше нет вагонов' if train_stopped? || @wagons.count == 0
    @wagons.delete_at(-1)
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

  def act_wagons(code)
    raise ArgumentError, 'Ошибка. У поезда нет вагонов' if wagons.count == 0
    wagons.each{|wagon| code.call(wagon)}
  end

  def list_wagons
    wagons.each_with_index { |wagon,number| puts "Вагон №#{number}, #{wagon.full_info}" }
  end

  def info
    "Поезд №#{number}, тип - #{type}, количество вагонов - #{wagons.count}"
  end

  protected

  attr_writer :wagons_amount, :wagons

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