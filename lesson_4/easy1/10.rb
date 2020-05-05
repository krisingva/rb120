# If we have the class below, what would you need to call to create a new
# instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# Answer: `Bag.new` and pass in two arguments: `Bag.new(arg1, arg2)`