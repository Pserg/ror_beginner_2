class Wagon
  include InstanceCounter
  include Manufacturer
  include Accessor

  attr_accessor_with_history :a, :b

  def initialize
    register_instance
  end
end
