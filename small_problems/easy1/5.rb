# Fix the Program - Persons
# Complete this program so that it produces the expected output:

# class Person
#   def initialize(first_name, last_name)
#     @first_name = first_name.capitalize
#     @last_name = last_name.capitalize
#   end

#   def to_s
#     "#{@first_name} #{@last_name}"
#   end
# end

# person = Person.new('john', 'doe')
# puts person

# person.first_name = 'jane'
# person.last_name = 'smith'
# puts person

# The above code should work for john doe but not for jane smith, we would need
# a setter method for that to work. Then you also have to move the call to
# `capitalize` to the `to_s` method for it output correctly for jane smith

class Person
  attr_writer :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{@first_name.capitalize} #{@last_name.capitalize}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person


# Expected output:

# John Doe
# Jane Smith

# LS (adds a cutomized setter method with a call to `capitalize`)
# Solution
# Add the following methods to the Person class:

# def first_name= (value)
#   @first_name = value.capitalize
# end

# def last_name= (value)
#   @last_name = value.capitalize
# end
# Discussion
# If you run the original code as-is, you'll get the following error:

# x.rb:15:in `<main>': undefined method `first_name=' for #<Person:0x007f8b33042980 @first_name="John", @last_name="Doe"> (NoMethodError)
# This is telling you that ruby is looking for a method named first_name= to set
# the value of the @first_name instance variable. You recognize that a shortcut
# for such a method can be defined with:

# attr_writer :first_name
# so add that to your class. Since you can see that you're also going to need a
# writer for @last_name, you add :last_name to that line as well:

# attr_writer :first_name, :last_name
# You run the code again, and get the following output:

# John Doe
# jane smith
# That's almost what we want, but not quite: Jane Smith's name is not
# capitalized. This is due to the fact that attr_writer doesn't do anything but
# assign a value directly to an instance variable. We want the name to be
# capitalized instead (and we should not expect the caller to do it for us). So,
# we remove the attr_writer call, and add the following setter methods:

# def first_name= (value)
#   @first_name = value.capitalize
# end

# def last_name= (value)
#   @last_name = value.capitalize
# end
# Now our program will run as expected.