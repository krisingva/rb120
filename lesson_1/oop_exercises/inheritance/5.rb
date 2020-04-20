# Move all of the methods from the MyCar class that also pertain to the MyTruck
# class into the Vehicle class. Make sure that all of your previous method calls
# are working when you are finished.

module Tow
  def can_tow
    "This vehicle can tow"
  end
end

class Vehicle

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

  def general_info
    "This vehicle is currently #{@on_off}, it is a #{self.year} #{self.color} #{self.model}."
  end

  def speed_info
    if @on_off == "on"
      "This vehicle is driving at #{@speed} mph."
    else
      "This vehicle is off"
    end
  end
end

class MyCar < Vehicle
  TYPE = "car"
end

class MyTruck < Vehicle
  TYPE = "truck"

  include Tow
end

p k_car = MyCar.new(1999, "blue", "Toyota")

p k_car.general_info
k_car.spray_paint("pink")
p k_car.general_info

p new_truck = MyTruck.new(2010, "silver", "Ford")
p new_truck.general_info
new_truck.spray_paint("lavender")
p new_truck.general_info
new_truck.speed_up(40)
p new_truck.speed_info
new_truck.speed_up(10)
p new_truck.speed_info