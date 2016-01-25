class Route
  attr_accessor :route
  def initialize(start_station, end_station)
    @route = [start_station, end_station]
    validate!
  end

  def add_station(station)
    @route.insert(-2, station)
    puts "Станция #{station.name} добавлена в маршрут"
  end

  def remove_station(station)
    @route.delete(station)
    puts "Станция #{station.name} удалена из маршрута"
  end

  def list_route
    puts 'Список станций маршрута: '
    @route.each { |station| print "#{station.name} -> " }
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    error_msg = 'Error. Incorrect format of the station as a parameter'
    fail ArgumentError, error_msg if route[0].class != RailwayStation || route[1] != RailwayStation
  end
end
