# Exercise 2b

class MyCar
  attr_reader :year
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

  def get_year
    self.year
  end

  def general_info
    "My car is currently #{@on_off}, it is a #{self.year} #{@color} #{@model}."
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
p k_car.general_info
p k_car.speed_info
p k_car.get_year
