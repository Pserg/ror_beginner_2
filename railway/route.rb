class Route
  include Validation

  attr_accessor :route
  attr_reader :start_station, :end_station

  validate :start_station, :presence
  validate :end_station, :presence
  validate :start_station, :type, RailwayStation
  validate :end_station, :type, RailwayStation

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @route = [@start_station, @end_station]
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

end
