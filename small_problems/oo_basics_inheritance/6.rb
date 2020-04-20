# Towable (Part 2)
# Using the following code, create a class named Vehicle that, upon
# instantiation, assigns the passed in argument to @year. Both Truck and Car
# should inherit from Vehicle.

# module Towable
#   def tow
#     'I can tow a trailer!'
#   end
# end

# class Truck
#   include Towable
# end

# class Car
# end

# truck1 = Truck.new(1994)
# puts truck1.year
# puts truck1.tow

# car1 = Car.new(2006)
# puts car1.year

module Towable
  def tow
    'I can tow a trailer!'
  end
end

class Vehicle
  attr_reader :year
  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  include Towable
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year

# Expected output:

# 1994
# I can tow a trailer!
# 2006

# LS:
# Discussion
# Modules are useful for containing similar methods, however, sometimes class
# inheritance is also needed. This exercise illustrates that it's possible to
# inherit from both a module and a class at the same time.

# In the solution, we've rewritten the Vehicle class used in earlier exercises.
# Then, to allow Truck and Car to access #year, we have both classes inherit
# from Vehicle.