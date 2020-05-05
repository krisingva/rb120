# The designers of the vehicle management system now want to make an adjustment
# for how the range of vehicles is calculated. For the seaborne vehicles, due to
# prevailing ocean currents, they want to add an additional 10km of range even
# if the vehicle is out of fuel.

# Alter the code related to vehicles so that the range for autos and motorcycles
# is still calculated as before, but for catamarans and motorboats, the range
# method will return an additional 10km.


# module Moveable
#   attr_accessor :speed, :heading
#   attr_writer :fuel_capacity, :fuel_efficiency

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include Moveable

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Seacraft
#   include Moveable

#   attr_reader :hull_count, :propeller_count

#   def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
#     @propeller_count = num_propellers
#     @hull_count = num_hulls
#     self.fuel_efficiency = fuel_efficiency
#     self.fuel_capacity = fuel_capacity
#   end
# end

# class Motorboat < Seacraft
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     # set up 1 hull and 1 propeller
#     super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

# class Catamaran < Seacraft
# end


module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  attr_writer :tires
  attr_reader :tires, :fuel_capacity, :fuel_efficiency

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Seacraft
  attr_reader :hull_count, :propeller_count, :fuel_capacity, :fuel_efficiency

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    @fuel_efficiency = fuel_efficiency
    @fuel_capacity = fuel_capacity
  end

  def range
    (@fuel_capacity * @fuel_efficiency) + 10
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Seacraft
end

# LS:
# We can over-ride the range method in the Seacraft class. This means that the
# range method of the Moveable module will continue to be effective for the
# autos and motorcycles, but that calling range on catamarans and motorboats
# will be handled by the range method defined on the Seacraft class and take
# precedence.

# We can use the super keyword to get the value from the Moveable module that's
# included by Seacraft, and then add the additional 10km of range before
# returning it.

# class Seacraft

#   # ... existing Seacraft code omitted ...

#   # the following is added to the existing Seacraft definition
#   def range
#     super + 10
#   end
# end