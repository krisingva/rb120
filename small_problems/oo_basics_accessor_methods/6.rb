# Guaranteed Formatting
# Using the following code, add the appropriate accessor methods so that @name
# is capitalized upon assignment.

# class Person
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

class Person

  def name
    @name
  end

  def name=(new_name)
    @name = new_name.capitalize
  end

end

# or:
# class Person
#   attr_reader :name

#   def name=(new_name)
#     @name = new_name.capitalize
#   end

# end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name


# Expected output:

# Elizabeth

# LS:
# Solution
# class Person
#   attr_reader :name

#   def name=(name)
#     @name = name.capitalize
#   end
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

# Discussion
# When handling data, sometimes it makes sense to format, or even validate, the
# data immediately. For instance, in the initial example, we're given the string
# 'eLiZaBeTh' and asked to format it while assigning it to the instance variable
# @name. This isn't an unrealistic request, due to the fact that first names are
# typically capitalized.

# To accomplish this, we need to manually write the setter method. Normally, we
# would use Ruby's built in accessor methods, but since we have to add extra
# functionality to the method, we're forced to implement our own.

# class Person
#   def name=(name)
#     @name = name
#   end
# end

# To capitalize @name upon assignment, all we need to do is invoke #capitalize
# on name. Using this approach guarantees that each person's name will always be
# formatted correctly.