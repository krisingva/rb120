# Create a superclass called Vehicle for your MyCar class to inherit from and
# move the behavior that isn't specific to the MyCar class to the superclass.
# Create a constant in your MyCar class that stores information about the
# vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that
# also has a constant defined that separates it from the MyCar class in some
# way.

# module VehicleFunctions
#   TYPE = nil

#   def general_info
#     "My #{TYPE} is currently #{@on_off}, it is a #{self.year} #{self.color} #{self.model}."
#   end
# end

class Vehicle
  attr_accessor :year, :color, :model

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    @speed = 0
    @on_off = "on"
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def self.mileage(num)
    "The mileage is #{num}"
  end

  def speed_up(acceleration)
    @speed += acceleration
  end

  def brake(deceleration)
    @speed -= deceleration
    if @speed < 0
      @speed = 0
      @on_off = "off"
    end
  end

  def off
    @speed = 0
    @on_off = "off"
  end


end

class MyCar < Vehicle
  TYPE = "car"

  # include VehicleFunctions

  def general_info
    "My #{TYPE} is currently #{@on_off}, it is a #{self.year} #{self.color} #{self.model}."
  end

  def speed_info
    if @on_off == "on"
      "My #{TYPE} is driving at #{@speed} mph."
    else
      "My #{TYPE} is off"
    end
  end
end

class MyTruck < Vehicle
  TYPE = "truck"

  def general_info
    "My #{TYPE} is currently #{@on_off}, it is a #{self.year} #{self.color} #{self.model}."
  end

  def speed_info
    if @on_off == "on"
      "My #{TYPE} is driving at #{@speed} mph."
    else
      "My #{TYPE} is off"
    end
  end
end

p k_car = MyCar.new(1999, "blue", "Toyota")

p k_car.general_info
k_car.spray_paint("pink")
p k_car.general_info

p new_truck = MyTruck.new(2010, "silver", "Ford")
p new_truck.general_info
new_truck.speed_up(40)
p new_truck.speed_info
new_truck.speed_up(10)
p new_truck.speed_info