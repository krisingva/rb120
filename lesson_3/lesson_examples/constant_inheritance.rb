# class Vehicle
#   def self.wheels
#     WHEELS
#   end

#   def wheels
#     WHEELS
#   end
# end

# class Car < Vehicle
#   WHEELS = 4

#   def self.wheels
#     WHEELS
#   end

#   def wheels
#     WHEELS
#   end
# end

# p Car.wheels
# # => 4

# a_car = Car.new
# p a_car.wheels
# # => 4

# p Vehicle.wheels
# => constant_inheritance.rb:3:in `wheels': uninitialized constant
# Vehicle::WHEELS (NameError)
# change the reference to `self.WHEELS`:

class Vehicle
  def self.wheels
    WHEELS
  end

  def wheels
    WHEELS
  end
end

class Car < Vehicle
  self::WHEELS = 4

  def self.wheels
    WHEELS
  end

  def wheels
    WHEELS
  end
end

p Car.wheels
# => 4

a_car = Car.new
p a_car.wheels
# => 4

p Vehicle.wheels