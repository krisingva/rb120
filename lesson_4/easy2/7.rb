# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works.
# Answer: It keeps the count of how many instances of `Cat` class there are
# What code would you need to write to test your theory?
p Cat.cats_count
# => 0
cat1 = Cat.new('beefy')
p Cat.cats_count
# => 1
cat2 = Cat.new('beefy')
p Cat.cats_count
# => 2

# LS:
# To test your theory you could print the value of the @@cats_count variable to
# the screen after it has been incremented, like this:

# def initialize(type)
#   @type = type
#   @age  = 0
#   @@cats_count += 1
#   puts @@cats_count
# end

# If you did this when you created more cats you could verify that the value was
# incremented.

# >> Cat.new(‘tabby’)
# 1
# => #<Cat:0x007fe05a0aebe0 @type=“tabby”, @age=0>
# >> Cat.new(‘russian blue’)
# 2
# => #<Cat:0x007fe05a0a74d0 @type=“russian blue”, @age=0>
# >> Cat.new(‘shorthair’)
# 3
# => #<Cat:0x007fe05a0a2d40 @type=“shorthair”, @age=0>
