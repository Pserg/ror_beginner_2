class CargoWagon < Wagon
  include Validation

  MAX_VOLUME = 1000

  attr_reader :volume, :start_volume

  validate :start_volume, :presence
  validate :start_volume, :format, /^\d{0,4}$/i
  validate :start_volume, :max_size, MAX_VOLUME

  def initialize(volume = MAX_VOLUME)
    @start_volume = volume
    @volume = volume
    validate!
  end

  def type
    :cargo
  end

  def take_volume(take_volume)
    valid_volume(take_volume)
    error_msg = 'Ошибка. Объем вагона будет переполнен'
    fail ArgumentError, error_msg if @volume - take_volume < 0
    @volume -= take_volume
  end

  def busy_volume
    start_volume - volume
  end

  def free_volume
    volume
  end

  def full_info
    "тип вагона - грузовой, занятый объем - #{busy_volume},
     свободный объем - #{free_volume}"
  end

  private

  attr_writer :volume

  def valid_volume(volume)
    error_msg = 'Ошибка. Неверный аргумент объема грузового вагона'
    fail ArgumentError, error_msg if volume.class != Fixnum || volume < 0 || volume > MAX_VOLUME
  end

end
