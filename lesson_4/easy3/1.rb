# If we have this code:

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

# What happens in each of the following cases:

# case 1:

hello = Hello.new
p hello.hi
#=> "Hello"

# case 2:

hello = Hello.new
hello.bye
# => NoMethodError for `bye`

# case 3:

hello = Hello.new
hello.greet
# => ArgumentError, expecting 1 but have 0

# case 4:

hello = Hello.new
hello.greet("Goodbye")
# => "Goodbye"

# case 5:

Hello.hi
# => NoMethodError, `hi` is an instance method, can only be called on objects, not the class