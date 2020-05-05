# In the last question we had the following classes:

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# If we call Hello.hi we get an error message. How would you fix this?

# Answer: Add `self.` infront of `hi` in method definition in the `Hello` class
# will make it a class method or just create an instance of `Hello` class and
# call the method on that:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi

# LS:
# You could define the hi method on the Hello class as follows:

class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

# This is rather cumbersome. Note that we cannot simply call greet in the
# self.hi method definition because the Greeting class itself only defines greet
# on its instances, rather than on the Greeting class itself.