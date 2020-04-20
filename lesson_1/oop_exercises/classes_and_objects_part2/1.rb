# Add a class method to your MyCar class that calculates the gas mileage of any car.

module CarColor
  def spray_paint(new_color)
    @color = new_color
  end
end

class MyCar
  include CarColor

  attr_reader :color

  @@mileage = 0

  def self.mileage(num)
    "The mileage is #{num}"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @on_off = "on"
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

  def get_color
    self.color
  end

  def general_info
    "My car is currently #{@on_off}, it is a #{@year} #{self.color} #{@model}."
  end

  def speed_info
    if @on_off == "on"
      "My car is driving at #{@speed} mph."
    else
      "My car is off"
    end
  end
end

k_car = MyCar.new(1999, "blue", "Toyota")

puts MyCar.mileage(22)