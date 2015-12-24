class Wagon
  include InstanceCounter
  include Manufacturer

  def initialize
    register_instance
  end



end