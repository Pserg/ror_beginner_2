class PassengerWagon < Wagon

  MAX_SEATS = 54

  attr_reader :number_of_seats, :seats

  def initialize(number_of_seats=MAX_SEATS)
    @number_of_seats = number_of_seats
    validate!
    @seats = {}
    number_of_seats.times { |seat_number| @seats[(seat_number + 1)] = 0 }

  end

  def type
    :passenger
  end

  def take_place
    raise ArgumentError, 'Нет свободных мест в вагоне' if seats.has_value?(0) == false
    seat = seats.detect {|k, v| v == 0}[0]
    seats[seat] = 1
  end

  def busy_places
    seats.select {|k,v| v == 1}.count
  end

  def free_places
    seats.select {|k,v| v == 0}.count
  end

  def full_info
    "тип вагона - пассажирский, количество занятых мест - #{busy_places}, количество свободных мест - #{free_places}"
  end

  def validate?
    validate!
  rescue
    false
  end


  private

  def validate!
    raise ArgumentError, 'Ошибка аргумента. Количество мест должно быть целым положительным числом не превышающим 54.' if number_of_seats.class != Fixnum && number_of_seats > 0 && number_of_seats <= MAX_SEATS
    true
  end

  attr_writer :number_of_seats, :seats

end