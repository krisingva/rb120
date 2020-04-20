# Continuing with our Person class definition, what does the below print out?

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

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# => Will return the object class (Person), name of instance (bob), @first_name="Robert", @last_name="Smith", object id number

# => The person's name is: #<Person:0x00007fa14d814b60>

# LS:
# The person's name is: #<Person:0x007fb873252640>
# This is because when we use string interpolation (as opposed to string
# concatenation), Ruby automatically calls the to_s instance method on the
# expression between the #{}. Every object in Ruby comes with a to_s inherited
# from the Object class. By default, it prints out some gibberish, which
# represents its place in memory.

# If we do not have a to_s method that we can use, we must construct the string
# in some other way. For instance, we can use:

# puts "The person's name is: " + bob.name        # => The person's name is:
# Robert Smith
# or

# puts "The person's name is: #{bob.name}"        # => The person's name is:
# Robert
