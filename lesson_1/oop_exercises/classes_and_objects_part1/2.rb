# Exercise 2

class MyCar
  attr_accessor :color
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

  def change_color(color)
    self.color = color
  end

  def general_info
    "My car is currently #{@on_off}, it is a #{@year} #{@color} #{@model}."
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
k_car.change_color("red")
k_car.speed_up(20)
p k_car.general_info
p k_car.speed_info
k_car.brake(30)
p k_car.general_info
p k_car.speed_info
k_car.off
p k_car.general_info
p k_car.speed_info

# LS:
# class MyCar
#   attr_accessor :color
#   attr_reader :year
#   # ... rest of class left out for brevity
# end

# lumina.color = 'black'
# puts lumina.color
# puts lumina.year