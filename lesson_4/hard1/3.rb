# Building on the prior vehicles question, we now must also track a basic
# motorboat. A motorboat has a single propeller and hull, but otherwise behaves
# similar to a catamaran. Therefore, creators of Motorboat instances don't need
# to specify number of hulls or propellers. How would you modify the vehicles
# code to incorporate a new Motorboat class?

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity

    # ... other code to track catamaran-specific data omitted ...
  end
end

class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

# LS:
# We can create a new class to present the common elements of motorboats and
# catamarans. We can call it, for example, Seacraft. We still want to include
# the Moveable module to get the support for calculating the range.

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

# We can now implement Motorboat based on the Seacraft definition. We don't need
# to include a reference to Moveable since that is already included in the
# Seacraft super class.

# class Motorboat < Seacraft
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     # set up 1 hull and 1 propeller
#     super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

#   And we alter the Catamaran to inherit from Seacraft and move hull and
#   propeller tracking out since it's taken over by Seacraft. We can also remove
#   the reference to the Moveable module.

# class Catamaran < Seacraft
#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

# The super method automatically receives and passes along any arguments which
# the original method received. Because of that, we can remove the arguments
# being passed into super:

# class Catamaran < Seacraft
#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     super
#   end
# end

# In fact, because super is the only statement in this initialize method and
# there's nothing to override, we can remove it altogether.

# class Catamaran < Seacraft
# end