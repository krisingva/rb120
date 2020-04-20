# Rectangles and Squares
# Given the following class:

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

# Write a class called Square that inherits from Rectangle, and is used like
# this:

class Square < Rectangle
  def initialize(side)
    @side = side
  end

  def area
    @side * @side
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"

# LS:
# Solution
# class Square < Rectangle
#   def initialize(length_of_side)
#     super(length_of_side, length_of_side)
#   end
# end

# Discussion
# The key thing to note for this problem is that we must call super in
# Square#initialize, and that Square inherits the area method from Rectangle.