# Fix The Program - Expander
# What is wrong with the following code? What fix(es) would you make?

# class Expander
#   def initialize(string)
#     @string = string
#   end

#   def to_s
#     self.expand(3)
#   end

#   private

#   def expand(n)
#     @string * n
#   end
# end

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    self.expand(3)
  end

  #private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

# Answer: The expand method was private, meaning that the instance was not able
# to access it when the to_s method was called on the instance by the line `puts
# expander`. Another fix could be to leave the expand method private but remove
# the `self.` from the to_s method and just have expand(3) in the method
# definition

# LS:
# Solution
# class Expander
#   ...
#   def to_s
#     expand(3)
#   end
#   ...
# end

# Discussion
# The Expand#to_s method tries to call the private #expand method with the
# syntax self.expand(3). This fails though, since private methods can never be
# called with an explicit caller, even when that caller is self. Thus, #expand
# must be called as expand(3).

# As of Ruby 2.7, it is now legal to call private methods with a literal self as
# the caller.

