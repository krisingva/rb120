# Using the class definition from step #3, let's create a few more people --
# that is, Person objects.

class Person
  attr_accessor :first_name, :last_name

  def initialize(fn, ln='')
    @first_name = fn
    @last_name = ln
  end

  def name
    if @last_name != ''
      @first_name + " " + @last_name
    else
      @first_name
    end
  end

  def name=(full_n)
    name_arr = full_n.split
    @first_name = name_arr[0]
    @last_name = name_arr[1] if name_arr.size > 1
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name,
# how can we compare the two objects?

p bob.name == rob.name
# => true
# p bob == rob
# # => false

# LS:
# We would not be able to do bob == rob because that compares whether the two
# Person objects are the same, and right now there's no way to do that. We have
# to be more precise and compare strings:

#   bob.name == rob.name
#   The above code compares a string with a string. But aren't strings also just
#   objects of String class? If we can't compare two Person objects with each
#   other with ==, why can we compare two different String objects with ==?

#   str1 = 'hello world'
#   str2 = 'hello world'

#   str1 == str2          # => true
#   What about arrays, hashes, integers? It seems like Ruby treats some core
#   library objects differently. For now, memorize this behavior. We'll explain
#   the underpinning reason in a future lesson.