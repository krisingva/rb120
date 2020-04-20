# Override the to_s method to create a user friendly print out of your object.


class MyCar

  attr_accessor :year, :color, :model

  def self.mileage(num)
    "The mileage is #{num}"
  end

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model
  end

  def to_s
    "My car is a #{color} #{year} #{model}"
  end
end

k_car = MyCar.new(1999, "blue", "Toyota")
puts k_car