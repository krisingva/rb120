# What could we add to the class below to access the instance variable @volume?

# class Cube
#   def initialize(volume)
#     @volume = volume
#   end
# end

# Answer: A getter method for the variable:
# attr_reader :volume

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

# LS:
# Technically we don't need to add anything at all. We are able to access
# instance variables directly from the object by calling instance_variable_get
# on the instance. This would return something like this:

# >> big_cube = Cube.new(5000)
# >> big_cube.instance_variable_get("@volume")
# => 5000

# While this works it is generally not a good idea to access instance variables
# in this way. Instead we can add a method to this object that returns the
# instance variable.

# An example of this would be adding a method called get_volume:

# class Cube
#   def initialize(volume)
#     @volume = volume
#   end

#   def get_volume
#     @volume
#   end
# end
# Now if we call get_volume on our big_cube we will get:

# >> big_cube.get_volume
# => 5000

