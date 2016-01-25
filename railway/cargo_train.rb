class CargoTrain < Train
  def initialize(number, wagons_amount)
    super
    wagons_amount.times { |num| wagons[num] = CargoWagon.new }
  end

  def type
    :cargo
  end
end
