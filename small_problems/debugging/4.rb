# Employee Management
# We have written some code for a simple employee management system. Each
# employee must have a unique serial number. However, when we are testing our
# program, an exception is raised. Fix the code so that the program works as
# expected without error.

class EmployeeManagementSystem
  attr_reader :employer

  def initialize(employer)
    @employer = employer
    @employees = []
  end

  def add(employee)
    if exists?(employee)
      puts "Employee serial number is already in the system."
    else
      employees.push(employee)
      puts "Employee added."
    end
  end

  alias_method :<<, :add
  # creating an alias for a method.
  # From docs:
  # https://docs.ruby-lang.org/en/2.6.0/Module.html#method-i-alias_method
  # Makes new_name a new copy of the method old_name. This can be used to retain
  # access to methods that are overridden.
  # Syntax:
  # alias_method (new_name, old_name)

  def remove(employee)
    if !exists?(employee)
      puts "Employee serial number is not in the system."
    else
      employees.delete(employee)
      puts "Employee deleted."
    end
  end

  def exists?(employee)
    employees.any? { |e| e == employee }
  end

  def display_all_employees
    puts "#{employer} Employees: "

    employees.each do |employee|
      puts ""
      puts employee.to_s
    end
  end

  private

  attr_accessor :employees
end

class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  # replace this:
  #private
  protected

  attr_reader :serial_number

  # add it here instead:
  private

  def abbreviated_serial_number
    serial_number[-4..-1]
  end
end

# Example

miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

becca = Employee.new('Becca', '232-4437-1932')
raul = Employee.new('Raul', '399-1007-4242')
natasha = Employee.new('Natasha', '399-1007-4242')

miller_contracting << becca     # => Employee added.
miller_contracting << raul      # => Employee added.
miller_contracting << raul      # => Employee serial number is already in the system.
miller_contracting << natasha   # => Employee serial number is already in the system.
miller_contracting.remove(raul) # => Employee deleted.
miller_contracting.add(natasha) # => Employee added.
# The above will raise an error because we created an alias for the `add`
# method, would have to use `<<` to call it. Not true!

miller_contracting.display_all_employees

# Result of running the code:
# 4.rb:69:in `==': private method `serial_number' called for
# #<Employee:0x00007fd4c80e7bb8> (NoMethodError)

# But the problem actually arises in the public
# `EmployeeMangagementSystem#exists?` method: `employees.any? { |e| e ==
# employee}` where `employees` is private and this then calls the public
# `Employee#==` method, where `serial_number` is private.

# Changing the `private` keyword to `protected` above `attr_reader
# :serial_number` and `abbreviated_serial_number` method definition.

# LS:
# Private methods cannot be invoked with an explicit caller, even inside of
# their own class. But on line 56 (69), in Employee#==, we do invoke
# serial_number with an explicit caller (other).

# In order to make this work, we can make serial_number a protected method.
# Recall that from outside the class, protected methods work just like private
# methods. From inside the class, however, protected methods are accessible and
# may be invoked with an explicit caller.

# Review:
# https://launchschool.com/books/oo_ruby/read/inheritance#privateprotectedandpublic