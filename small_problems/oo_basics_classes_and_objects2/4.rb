# Generic Greeting (Part 2)
# Using the following code, add two methods: ::generic_greeting and
# #personal_greeting. The first method should be a class method and print a
# greeting that's generic to the class. The second method should be an instance
# method and print a greeting that's custom to the object.

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting

# Expected output:

# Hello! I'm a cat!
# Hello! My name is Sophie!

# LS:
# Discussion
# There are a few differences between class methods and instance methods,
# however, most notably, class methods are only associated with the class
# itself, not any instance of the class. Within class methods, we're restricted
# from adding data specific to objects of the class, like adding a name to an
# instance of Cat. Think of class methods as generic actions a class may
# perform, like this:

# class Cat
#   def self.speak
#     puts 'Meow!'
#   end
# end

# Cat.speak # => Meow!
# We know that cats meow, therefore, it makes sense to add #speak as a generic
# action for Cat.