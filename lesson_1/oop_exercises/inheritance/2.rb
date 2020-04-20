# Add a class variable to your superclass that can keep track of the number of
# objects created that inherit from the superclass. Create a method to print out
# the value of this class variable as well.

class Vehicle
  # LS:
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  # Mine:
  @@number = 0

  def number
    @@number
  end

  attr_accessor :year, :color, :model

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
    @speed = 0
    @on_off = "on"
    @@number += 1
    @@number_of_vehicles += 1
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
p k_car.number               # My method, works
p Vehicle.number             # Gives an error
p Vehicle.number_of_vehicles # LS method, works
p k_car.number_of_vehicles   # Gives an error
# Why doesn't k_car have access to the method?