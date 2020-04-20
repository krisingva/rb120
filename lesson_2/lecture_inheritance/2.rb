# Let's create a few more methods for our Dog class.

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

# Create a new class called Cat, which can do everything a dog can, except swim
# or fetch. Assume the methods do the exact same thing. Hint: don't just copy
# and paste all methods in Dog into Cat; try to come up with some class
# hierarchy.

class Cat < Dog
  def swim
    "can't swim!"
  end

  def fetch
    "can't fetch!"
  end
end

kit = Cat.new
puts kit.speak
puts kit.swim
puts kit.run
puts kit.jump
puts kit.fetch
# =>
# bark!
# can't swim!
# running!
# jumping!
# can't fetch!

# LS:
# We could just duplicate the methods in the Cat class. But that wouldn't be
# DRY, and this is exactly why we OOP -- to allow us to organize behaviors into
# classes, and set up a hierarchical structure that takes advantage of
# inheritance. Inheriting behaviors is a way to re-use common behaviors.

# class Pet
#   def run
#     'running!'
#   end

#   def jump
#     'jumping!'
#   end
# end

# class Dog < Pet
#   def speak
#     'bark!'
#   end

#   def fetch
#     'fetching!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# class Cat < Pet
#   def speak
#     'meow!'
#   end
# end
#   It's getting slightly more complicated, but we've shuffled the methods
#   (behaviors) around a bit into their appropriate classes. All pets (that we
#   know of so far) can run and jump, so those two methods are in the Pet class.
#   On top of those two behaviors, dogs can further fetch and swim, so those two
#   methods are added to the Dog class. Cats don't have any additional behaviors
#   (we'll talk about speak below).

# Both dogs and cats can speak, so why not have that behavior in the Pet class?
# The reason is because we do not have a good default for speak for all pets, so
# we don't want to jump to conclusions and allow specific pets (ie, the
# sub-classes) to implement that method.

# Let's make sure everything works as expected.

# pete = Pet.new
# kitty = Cat.new
# dave = Dog.new
# bud = Bulldog.new

# pete.run                # => "running!"
# pete.speak              # => NoMethodError

# kitty.run               # => "running!"
# kitty.speak             # => "meow!"
# kitty.fetch             # => NoMethodError

# dave.speak              # => "bark!"

# bud.run                 # => "running!"
# bud.swim                # => "can't swim!"