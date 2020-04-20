# Fix the Program - Flight Data
# Consider the following class definition:

# class Flight
#   attr_accessor :database_handle

#   def initialize(flight_number)
#     @database_handle = Database.init
#     @flight_number = flight_number
#   end
# end

# There is nothing technically incorrect about this class, but the definition
# may lead to problems in the future. How can this class be fixed to be
# resistant to future problems?

# Notes: `database_handle` has a getter and setter method. During initialization, a `flight_number` is passed in as an argument and `database_handle` is set by calling `init` on `Database` class. That leaves the possibility of `database_handle` to be modified outside the `Flight` class which might not be optimal. Instead you could create a variable `database_handle` outside the `Flight` class and pass it in with `flight_number` as an argument to `initialize`.

class Flight

  def initialize(flight_number, database_handle)
    @database_handle = database_handle
    @flight_number = flight_number
  end
end

database_handle = Database.init

# LS:
# Approach/Algorithm
# Hint: Consider what might happen if you leave this class defined as it is, and
# later decide to alter the implementation so that a database is not used.

# Solution
# Delete the following line:

# attr_accessor :database_handle

# Discussion
# The problem with this definition is that we are providing easy access to the
# @database_handle instance variable, which is almost certainly just an
# implementation detail. As an implementation detail, users of this class should
# have no need for it, so we should not be providing direct access to it.

# The fix is easy: don't provide the unneeded and unwanted attr_accessor.

# What can go wrong if we don't change things? First off, by making access to
# @database_handle easy, someone may use it in real code. And once that database
# handle is being used in real code, future modifications to the class may break
# that code. You may even be prevented from modifying your class at all if the
# dependent code is of greater concern.