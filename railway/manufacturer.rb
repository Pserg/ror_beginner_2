module Manufacturer

  def set_manufacturer(manufacturer)
    self.manufacturer = manufacturer
  end

  def get_manufacturer
    manufacturer
  end

  protected
  attr_accessor :manufacturer
end
