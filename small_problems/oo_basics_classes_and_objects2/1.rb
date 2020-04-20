# Generic Greeting (Part 1)
# Modify the following code so that Hello! I'm a cat! is printed when
# Cat.generic_greeting is invoked.

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat"
  end
end

Cat.generic_greeting

# Expected output:

# Hello! I'm a cat!

# LS:
# Discussion
# When looking at the initial example, the first thing you should notice is the
# invocation of #generic_greeting. It's being invoked on the Cat class, not an
# instance of Cat. This indicates that #generic_greeting is a class method.

# Class methods are defined differently than instance methods. When defining a
# class method, the method name is prepended with self, like this:
# self.generic_greeting. In the solution, self refers to the Cat class. This
# means we could also define #generic_greeting as Cat.generic_greeting. However,
# self is preferred when defining class methods.

# Like instance methods, we can place any statement we want inside a class
# method. In our solution, we place puts 'Hello! I'm a cat!' so that Hello! I'm
# a cat! is printed when #generic_greeting is invoked.

# To invoke class methods, they must be called on the class itself, not an
# instance of the class. If we invoke a class method on an instance of the
# class, we'll get a NoMethodError

# Further Exploration
# What happens if you run kitty.class.generic_greeting? Can you explain this
# result?

# class Cat
#   def self.generic_greeting
#     puts "Hello! I'm a cat"
#   end
# end

# kitty = Cat.new
# kitty.class.generic_greeting

# Answer:
# `kitty.class` will return `Cat` so it will result in the same as calling
# `Cat.genreic_greeting`