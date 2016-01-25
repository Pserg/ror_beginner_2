class RailwayStation
  @@stations = []

  attr_reader :name, :trains

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def accept_train(train)
    error_msg = 'Ошибка. Передан неверный параметр в качестве аргумента'
    fail ArgumentError, error_msg if train.class.superclass != Train
    @trains << train
  end

  def list_trains
    puts "Список поездов на станции #{@name}:   "
    @trains.each { |train| print "\nПоезд №#{train.number}." }
  end

  def list_trains_by_type
    puts "Список пассажирских поездов на станции #{@name}:   "
    @trains.each { |train| print "\nПоезд №#{train.number}." if train.type == :passenger }
    puts "Список грузовых поездов на станции #{@name}:   "
    @trains.each { |train| print "\nПоезд №#{train.number}." if train.type == :cargo }
  end

  def send_train(train)
    error_msg = 'Ошибка. Передан неверный параметр в качестве аргумента'
    fail ArgumentError, error_msg if train.class.superclass != Train
    @trains.delete(train)
    puts "Поезд №#{train.object_id} отправился со станции #{@name}"
  end

  def valid?
    validate!
  rescue
    false
  end

  def act_trains(code)
    trains.each { |train| code.call(train) }
  end

  private

  attr_writer :trains

  def validate!
    error_msg = 'Ошибка в названии станции.'
    fail ArgumentError, error_msg if name.length < 2 && name.length > 30
    true
  end
end
