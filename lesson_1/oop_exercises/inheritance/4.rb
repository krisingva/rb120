# Print to the screen your method lookup for the classes that you have created.

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

  include Tow

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

puts "Vehicle lookup:"
puts Vehicle.ancestors

puts "MyCar lookup:"
puts MyCar.ancestors

puts "MyTruck lookup:"
puts MyTruck.ancestors