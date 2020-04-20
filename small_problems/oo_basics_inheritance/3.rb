# Only Pass the Year
# Using the following code, allow Truck to accept a second argument upon
# instantiation. Name the parameter bed_type and implement the modification so
# that Car continues to only accept one argument.

# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994, 'Short')
# puts truck1.year
# puts truck1.bed_type

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  attr_reader :bed_type

  def initialize(year, bed_type)
    @year = year
    @bed_type = bed_type
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type


# Expected output:

# 1994
# Short

# LS:

# Solution
# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   attr_reader :bed_type

#   def initialize(year, bed_type)
#     super(year)
#     @bed_type = bed_type
#   end
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994, 'Short')
# puts truck1.year
# puts truck1.bed_type

# Discussion
# Knowing that all vehicles don't have beds, it makes sense for only Truck to
# accept a bed_type argument. However, we still want to keep the @year instance
# variable in Vehicle. To accomplish this, we need to use #super. Unlike the
# previous exercise, though, we only want to pass one argument - year - instead
# of all of them.

# To pass specific arguments with #super, we need to list the arguments within
# parentheses, like this:

# def a_method(one, two, three)
#   super(one, three)
# end
# In the solution, we added #initialize to Truck instead of modifying
# #initialize in Vehicle because we didn't want Car to accept the bed_type
# parameter.

