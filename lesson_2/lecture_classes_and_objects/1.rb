# Given the below usage of the Person class, code the class definition.

# class Person
#   def initialize(name)
#     @name = name
#   end

#   def name
#     @name
#   end

#   def name=(new_name)
#     @name = new_name
#   end
# end

# or:
# class Person
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

# end

#or:
# class Person
#   attr_writer :name

#   def initialize(name)
#     @name = name
#   end

#   def name
#     @name
#   end
# end

#or:
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(new_name)
    @name = new_name
  end
end

bob = Person.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'