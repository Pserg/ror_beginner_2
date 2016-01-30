class PassengerWagon < Wagon
  include Validation

  MAX_SEATS = 54

  attr_reader :number_of_seats, :seats

  validate :number_of_seats, :presence
  validate :number_of_seats, :format, /^\d{0,2}$/i
  validate :number_of_seats, :max_size, MAX_SEATS

  def initialize(number_of_seats = MAX_SEATS)
    @number_of_seats = number_of_seats
    @seats = {}
    number_of_seats.times { |seat_number| @seats[(seat_number + 1)] = 0 }
    validate!
  end

  def type
    :passenger
  end

  def take_place
    fail ArgumentError, 'No free places in wagon' unless seats.value?(0)
    seat = seats.detect { |_, v| v == 0 }[0]
    seats[seat] = 1
  end

  def busy_places
    seats.count { |_, v| v == 1 }
  end

  def free_places
    seats.count { |_, v| v == 0 }
  end

  def full_info
    "тип вагона - пассажирский, количество занятых мест - #{busy_places},
    количество свободных мест - #{free_places}"
  end

  private

  attr_writer :number_of_seats, :seats
end
