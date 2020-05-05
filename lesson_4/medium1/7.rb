# How could you change the method name below so that the method name is more
# clear and less repetitive?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

# Answer: The method `self.light_information` is a class method of the class
# `Light` so it could be renamed: `self.information`.
# Or you could make it an instance method: `light_information` and inside the
# method, you could have string interpolation of `@brightness` and `@color` for
# the calling object: "I want to turn on the light with a brightness level of
# #{brightness} and a colour of #{color}"

# LS: Currently the method is defined as self.light_information, which seems
# reasonable. But when using or invoking the method, we would call it like this:
# Light.light_information. Having the word "light" appear twice is redundant.
# Therefore, we can rename the method to just self.information, and we can
# invoke it like this Light.information. This reads much better -- remember,
# you're writing code to be readable by others as well as your future self.
