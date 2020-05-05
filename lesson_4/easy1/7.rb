# What is the default return value of to_s when invoked on an object? Where
# could you go to find out if you want to be sure?

# The default would be the return value of to_s method as defined in `Object`
# class.
# https://docs.ruby-lang.org/en/2.6.0/Object.html#method-i-to_s
# to_s → string
# Returns a string representing obj. The default to_s prints the object's class
# and an encoding of the object id. As a special case, the top-level object that
# is the initial execution context of Ruby programs returns “main''.