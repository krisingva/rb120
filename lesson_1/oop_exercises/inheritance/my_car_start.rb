class MyCar
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

  def to_s
    "My car is a #{color} #{year} #{model}"
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
    "My car is currently #{@on_off}, it is a #{self.year} #{self.color} #{self.model}."
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
k_car.speed_up(20)
p k_car.general_info
p k_car.speed_info
k_car.brake(30)
p k_car.general_info
k_car.spray_paint("red")
p k_car.general_info