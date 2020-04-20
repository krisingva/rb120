# Inherited Year
# Using the following code, create two classes - Truck and Car - that both
# inherit from Vehicle.

# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# truck1 = Truck.new(1994)
# puts truck1.year

# car1 = Car.new(2006)
# puts car1.year


class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year

car1 = Car.new(2006)
puts car1.year

# Expected output:

# 1994
# 2006

LS:

Sign Out
RB120 - Object Oriented ProgrammingOO Basics: InheritanceInherited Year
Give us your feedback
Inherited Year
Using the following code, create two classes - Truck and Car - that both inherit from Vehicle.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

truck1 = Truck.new(1994)
puts truck1.year

car1 = Car.new(2006)
puts car1.year
Expected output:

1994
2006
Hide Solution & Discussion
Solution
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year

car1 = Car.new(2006)
puts car1.year

# LS:
# Discussion
# When designing an Object Oriented program, it's common to have multiple classes that perform similar actions. For example, both Truck and Car use the instance variable @year. To reduce complexity, classes with similar behaviors can inherit from a superclass. The superclass implements the common behaviors while the inheriting classes invoke them.

# In the solution, Truck and Car inherit @year from Vehicle. The < symbol is used to denote inheritance between classes.