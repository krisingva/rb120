# If we have a class such as the one below:

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end

# In the make_one_year_older method we have used self. What is another way we
# could write this method so we don't have to use the self prefix?

# class Cat
#   attr_accessor :type#, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def age
#     @age
#   end

#   def set_age=(new_age)
#     @age = new_age
#   end

#   def make_one_year_older
#     new_age = age + 1
#     p new_age
#     set_age=(new_age)
#   end
# end

# Above doesn't work, have to use `self.` infront of setter method.

# change the `self.age` to `@age`
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end

cat = Cat.new('chubby')
# cat.set_age=(5)
cat.make_one_year_older
p cat.age

# LS:
# self in this case is referencing the setter method provided by attr_accessor -
# this means that we could replace self with @. This means in this case self and
# @ are the same thing and can be used interchangeably.