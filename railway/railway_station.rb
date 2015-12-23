class RailwayStation

  @@stations = []

  attr_accessor :name

  def self.all
    @@stations
  end

  def initialize (name)
    @name = name
    @trains = []
    @@stations << self
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
    @trains.each {|train| print "\nПоезд №#{train.object_id}." if train.type == :passenger}
    puts "Список грузовых поездов на станции #{@name}:   "
    @trains.each {|train| print "\nПоезд №#{train.object_id}." if train.type == :cargo}
  end

  def send_train(train)
    @trains.delete(train)
    puts "Поезд №#{train.object_id} отправился со станции #{@name}"
  end

end