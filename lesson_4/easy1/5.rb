# Which of these two classes has an instance variable and how do you know?

  class Fruit
    def initialize(name)
      name = name
    end
  end

  class Pizza
    def initialize(name)
      @name = name
    end
  end

# Answer: The `Pizza` class, an instance variable will have an `@` in front of
# it. In the `initialize` method for `Fruit`, we are creating a new local
# variable `name` that is only scoped inside the method and can't be used
# outside of it. The instance variable `@name` in `Pizza` is available to all
# instances of `Pizza` class

# LS:
# But let us be triple sure that only Pizza has an instance variable by asking
# our objects if they have instance variables.

# To do this we first need to create a Pizza object and a Fruit object.

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

# Now we can ask each of these objects if they have instance variables.

p hot_pizza.instance_variables
# => [:@name]
p orange.instance_variables
# => []

# As you can see, if we call the instance_variables method on the instance of
# the class we will be informed if the object has any instance variables and
# what they are.

# See
# https://docs.ruby-lang.org/en/2.6.0/Object.html#method-i-instance_variables

# By doing this we have found out that Pizza has instance variables while Fruit
# does not.