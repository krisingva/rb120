# When running the following code...

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
p bob.name = "Bob"

# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
# Why do we get this error and how to we fix it?

# Answer:
# The error arrives from not having a setter method for the name variable.
# To fix it change line 4 to:
# attr_accessor :name