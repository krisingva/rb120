# Alyssa has been assigned a task of modifying a class that was initially
# created to keep track of secret information. The new requirement calls for
# adding logging, when clients of the class attempt to access the secret data.
# Here is the class in its current form:

# class SecretFile
#   attr_reader :data

#   def initialize(secret_data)
#     @data = secret_data
#   end
# end

# She needs to modify it so that any access to data must result in a log entry
# being generated. That is, any call to the class which will result in data
# being returned must first call a logging class. The logging class has been
# supplied to Alyssa and looks like the following:

# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#   end
# end

# Hint: Assume that you can modify the initialize method in SecretFile to have
# an instance of SecurityLogger be passed in as an additional argument. It may
# be helpful to review the lecture on collaborator objects for this practice
# problem.

# bob = SecretFile.new('bob')
# pam = SecretFile.new('pam')
# p pam.data
# # => "pam"

# Answer: Define reader as a customized method so that when reader is called, a
# log entry is created. Have to initialize each object of `SecretFile` class
# with a variable `@log` that is a new instance of `SecurityLogger` class.
# Inside the `SecurityLogger` class we initialize an object with
# `@count_of_logs` set to 0 and we have a method `create_log_entry` that adds
# one to `@count_of_logs` and displays the log and count. This method is called
# inside the `SecretFile` class' customized getter method for `@data`

class SecretFile
  def initialize(secret_data)
    @data = secret_data
    @log = SecurityLogger.new
  end

  def get_data
    @log.create_log_entry
    @data
  end
end

class SecurityLogger
  attr_accessor :count_of_logs
  def initialize
    @count_of_logs = 0
  end

  def create_log_entry
    self.count_of_logs += 1
    puts "log created"
    puts "there are #{count_of_logs} logs for this user"
  end
end

bob = SecretFile.new('bob')
pam = SecretFile.new('pam')
5.times {pam.get_data}
# => log created
# => there are 1 logs for this user
# ...
# => log created
# => there are 5 logs for this user

# LS:
# First modify the initialize method to take a SecurityLogger object as an
# argument and assign it to another instance variable.

# class SecretFile
#   attr_reader :data

#   def initialize(secret_data, logger)
#     @data = secret_data
#     @logger = logger
#   end
# end

# Second, Alyssa needs to remove the attr_reader and replace it with an explicit
# implementation of a method that returns the data instance variable. In that
# new method, she can add a call to the security logger.

# class SecretFile
#   def initialize(secret_data, logger)
#     @data = secret_data
#     @logger = logger
#   end

#   def data
#     @logger.create_log_entry
#     @data
#   end
# end