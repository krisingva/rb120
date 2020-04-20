# Start the Engine (Part 1)
# Change the following code so that creating a new Truck automatically invokes
# #start_engine.

# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# truck1 = Truck.new(1994)
# puts truck1.year


class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle

  def initialize(year)
    @year = year
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year


# Expected output:

# Ready to go!
# 1994

# LS:

# Solution
# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   def initialize(year)
#     super
#     start_engine
#   end

#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# truck1 = Truck.new(1994)
# puts truck1.year
# Discussion
# When working with class inheritance, it's possible for methods to overlap.
# It's easy to override an inherited method. For example:

# class Vehicle
#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# class Truck < Vehicle
#   def start_engine
#     puts "I'm a truck! Let's go!"
#   end
# end

# truck1 = Truck.new
# truck1.start_engine # => "I'm a truck! Let's go!"
# The reason that Truck#start_engine executes instead of Vehicle#start_engine
# has to do with the order in which Ruby looks through the inheritance hierarchy
# for a method. Here, the sequence looks like this:

# Truck
# Vehicle
# Object
# Kernel
# BasicObject
# Ruby stops looking for the method as soon as it finds it. Thus,
# Truck#start_engine overrides Vehicle#start_engine. What if we want to override
# a method, but still have access to functionality from a superclass? Ruby
# provides a reserved word for this: super.

# When you invoke #super within a method, Ruby looks in the inheritance
# hierarchy for a method with the same name. In the solution, we use #super to
# invoke Vehicle#initialize, then we invoke #start_engine. Invoking #super
# without parentheses passes all arguments to Vehicle#initialize.