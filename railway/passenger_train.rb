class PassengerTrain < Train

  def initialize(number, wagons_amount)
    super
    wagons_amount.times {|num| wagons[num] = PassengerWagon.new }
  end

  def type
    :passenger
  end
end