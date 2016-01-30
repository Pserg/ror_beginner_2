class CargoTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :wagons_amount, :presence
  validate :wagons_amount, :max_size, MAX_WAGONS_AMOUNT

  def initialize(number, wagons_amount)
    super
    wagons_amount.times { |num| wagons[num] = CargoWagon.new }
  end

  def type
    :cargo
  end
end
