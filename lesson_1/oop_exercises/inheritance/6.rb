# Write a method called age that calls a private method to calculate the age of
# the vehicle. Make sure the private method is not available from outside of the
# class. You'll need to use Ruby's built-in Time class to help.


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

  def age
    "This car is #{calculate_age} years old"
  end

  private

  def calculate_age
    current_year = Time.new.year
    current_year - self.year
  end
end

class MyTruck < Vehicle
  TYPE = "truck"

  include Tow
end

p k_car = MyCar.new(1999, "blue", "Toyota")
p k_car.general_info
p k_car.age
# => "This car is 21 years old" (public method)
p k_car.calculate_age
# => private method `calculate_age' called for #<MyCar:0x00007fc6938a2d78> (NoMethodError)

p new_truck = MyTruck.new(2010, "silver", "Ford")
p new_truck.general_info