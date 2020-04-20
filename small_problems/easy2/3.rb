# Complete The Program - Houses
# Assume you have the following code:

# class House
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end
# end

# Notes: have to make the objects home1 and home2 be presented by the value of
# the @price variable
# From Object class documentation:
# https://docs.ruby-lang.org/en/2.6.0/Object.html#method-i-3C-3D-3E
# When you define <=>, you can include Comparable to gain the methods <=, <, ==,
# >=, > and between?.

class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=> (other)
    self.price <=> other.price
  end

  # def self
  #   @price
  # end
  # this doesn't work, gives an error message
  #   undefined method `<' for #<House:0x00007f895f119d48 @price=100000>
  #   (NoMethodError)
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# and this output:

# Home 1 is cheaper
# Home 2 is more expensive

# Modify the House class so that the above program will work. You are permitted
# to define only one new method in House.

# LS:
# Approach/Algorithm
# You may find the Comparable module useful.

# Solution
# class House
#   attr_reader :price
#   include Comparable

#   def initialize(price)
#     @price = price
#   end

#   def <=>(other)
#     price <=> other.price
#   end
# end

# ...

# Discussion
# Making objects comparable is actually quite easy; you don't have to create
# every possible comparison operator for the object. Instead, all you need to do
# is include the Comparable mixin, and define one method: <=>. The <=> method
# should return 0 if the two objects are "equal", 1 if the receiving object is
# greater than the other object, and -1 if the receiving object is less than the
# other object. Often, as here, the comparison will boil down to comparing
# numbers or strings, both of which already have a <=> operator defined. Thus,
# you rarely have to write an involved #<=> method.

# Further Exploration
# Is the technique we employ here to make House objects comparable a good one?
# (Hint: is there a natural way to compare Houses? Is price the only criteria
# you might use?) What problems might you run into, if any? Can you think of any
# sort of classes where including Comparable is a good idea?

# Other things to consider when comparing House objects: size, number of rooms,
# location. For many factors you could simply say bigger is better but for other
# factors such as location, it would be harder to compare two objects. Any
# classes that have objects with instance variables represented by integers or
# strings would be a good example for using Comparable