# Fix the Program - Drivable
# Correct the following program so it will work properly. Assume that the Car
# class has a complete implementation; just make the smallest possible change to
# ensure that cars have access to the drive method.

# module Drivable
#   def self.drive
#   end
# end

# class Car
#   include Drivable
# end

# Answer: Remove the `self.` from the drive method. When the module is included in the `Car` class, the `self.` in the drive method would imply a class method and the objects would not have access to it.
module Drivable
  def drive
  end
end

class Car
  include Drivable
end


bobs_car = Car.new
bobs_car.drive

# LS:
# Solution
# Modify the self.drive method in Drivable to simply drive:

# def drive
# end

# Discussion
# Methods in mixin modules should be defined without using self. in the
# definition. If you add self. to the definition, the including class will only
# be able to access the method by calling Drivable.drive; furthermore, the
# method will not be available at all as an instance method to objects.