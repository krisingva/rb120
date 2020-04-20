# Towable (Part 1)
# Using the following code, create a Towable module that contains a method named
# tow that prints I can tow a trailer! when invoked. Include the module in the
# Truck class.

# class Truck
# end

# class Car
# end

# truck1 = Truck.new
# truck1.tow

module Towable
  def tow
    puts "I can tow a trailer!"
  end
end

class Truck
  include Towable
end

class Car
end

truck1 = Truck.new
truck1.tow

# Expected output:

# I can tow a trailer!

# LS:
# Discussion
# Modules are useful for organizing similar methods that may be relevant to
# multiple classes. For instance, the module Towable contains the method #tow.
# Typically, you use a Truck for towing, not a Car, which means #tow is only
# relevant to Truck objects.

# With modules, we have the ability to include them in specific classes. In the
# solution, we use the reserved word include to give Truck access to the #tow
# method in Towable.