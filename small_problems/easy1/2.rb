# What's the Output?
# Take a look at the following code:

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# #=> "My name is FLUFFY"
# puts fluffy
# puts fluffy.name
# puts name

# What output does this code print? Fix this class so that there are no
# surprises waiting in store for the unsuspecting developer.

# Step by step approach:
# Step 1, when calling `fluffy = Pet.new(name)`, name refers to the variable set in the line above (`name = 'Fluffy'`)

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

# end

# name = 'Fluffy'
# p fluffy = Pet.new(name)
#<Pet:0x00007f84310e62f0 @name="Fluffy">

# Step 2: When calling `fluffy = Pet.new(name)` with the `.to_s` in `initialize`
# method and the class custom `to_s` method.
# Inside initialize:
# @name becomes "Fluffy".to_s
# Inside to_s:
# @name is going to refer to name because of getter method ("Fluffy")
# @name.upcase! will return "FLUFFY"
# now @name has been mutated to "FLUFFY" so "My name is #{@name}" will return
# "My name is FLUFFY" which is what the initialize method will return
# `fluffy = Pet.new(name)` will return the object id with @name="My name is
# FLUFFY"


# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# p fluffy = Pet.new(name)

# Wrong! this still returns:
#<Pet:0x00007fe63a904b38 @name="Fluffy">

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
#=>Fluffy

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# #=> Fluffy
# puts fluffy
# #=> My name is FLUFFY.
# puts fluffy.name
# #=> FLUFFY
# puts name
# #=> FLUFFY

# Fix: Make name stay "Fluffy" but when calling `to_s` using the `puts` method
# on the instance fluffy, output "My name is FLUFFY."


# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# #=> Fluffy
# puts fluffy
# #=> My name is FLUFFY.
# puts fluffy.name
# #=> Fluffy
# puts name
# #=> Fluffy

# LS:

# Solution
# Output:

# Fluffy
# My name is FLUFFY.
# FLUFFY
# FLUFFY
# Corrected Class:

# class  Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end

# Discussion
# The original version of #to_s uses String#upcase! which mutates its argument
# in place. This causes @name to be modified, which in turn causes name to be
# modified: this is because @name and name reference the same object in memory.

# Oh, and that to_s inside the initialize method? We need that for the challenge
# under Further Exploration.

# Further Exploration
# This code "works" because of that mysterious to_s call in Pet#initialize.
# However, that doesn't explain why this code produces the result it does. Can
# you?
# What would happen in this case?
# Original version:
# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 42
# fluffy = Pet.new(name)
# # fluffy instance created with name variable set to 42
# name += 1
# # reassigning name outside the class should not affect fluffy `@name` instance
# # variable
# puts fluffy.name
# # => 42
# puts fluffy
# # => My name is 42.
# puts fluffy.name
# # => 42
# puts name
# # => 43

# Correct!

# Fixed version:
class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# same as original

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# LS Discussions regarding calling `to_s` in `intialize` method:
# I have a question regarding the second question in the Easy 1 set of
# exercises.

# class  Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name # => "42"
# puts fluffy # => "My name is 42."
# puts fluffy.name # => "42"
# puts name # => "43"
# Why does the to_s inside of initialize not call the to_s defined within Pet?

# Pete Hanson
# 4 months ago
# Instead of a direct answer, let me ask you a couple of questions. What object
# is calling #to_s on line 5? What objects should call the #to_s defined inside
# Pet?

# The object calling #to_s on line 5 is the integer value reference by the local
# variable name. Reading your second question I'm assuming that the #to_s that
# was defined on lines 8-10 has to be called on an instance of the Pet class
# because as it is right now I'm calling it on an object from the Integer class,
# and unless I defined #to_s the same way I defined it in the Pet class inside
# of the Integer class, it's not going to output what's on line 9.
