# Exercise 3

module CarColor
  def spray_paint(new_color)
    @color = new_color
  end
end

class MyCar
  include CarColor

  attr_reader :color
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
k_car.spray_paint("red")
p k_car.get_color
p k_car.general_info

# LS:
# class MyCar
#   attr_accessor :color
#   attr_reader :year

#   # ... rest of class left out for brevity

#   def spray_paint(color)
#     self.color = color
#     puts "Your new #{color} paint job looks great!"
#   end
# end

# lumina.spray_paint('red')   #=> "Your new red paint job looks great!"