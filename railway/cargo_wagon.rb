class CargoWagon < Wagon

  MAX_VOLUME = 1000

  attr_reader :volume, :start_volume

  def initialize(volume=MAX_VOLUME)
    @start_volume = volume
    @volume = volume
    validate!
  end

  def type
    :cargo
  end

  def take_volume(take_volume)
    valid_volume(take_volume)
    raise ArgumentError, 'Ошибка. Объем вагона будет переполнен' if @volume - take_volume < 0
    @volume -= take_volume
  end

  def busy_volume
    start_volume - volume
  end

  def free_volume
    volume
  end

  def valid?
    validate!
  rescue
    false
  end

  def full_info
      "тип вагона - грузовой, занятый объем - #{busy_volume}, свободный объем - #{free_volume}"
    end

  private
  attr_writer :volume

  def valid_volume(volume)
    raise ArgumentError, 'Ошибка. Неверный аргумент объема грузового вагона' if volume.class != Fixnum || volume < 0 || volume > MAX_VOLUME
  end

  def validate!
    valid_volume(@volume)
    true
  end

end
