# What is a module? What is its purpose? How do we use them with our classes?
# Create a module for the class you created in exercise 1 and include it
# properly.

# Answer:
# A module is a collection of methods that can be included in a class by mixing
# the module with the class, using the `include` method

Module NewModule
  def say_please
    puts "Please"
  end
end

class MyClass
  include NewModule
end

# LS:
# 1. A module allows us to group reusable code into one place. We use modules in
# our classes by using the include method invocation, followed by the module
# name.
# 2. Modules are also used as a namespace (when a module is used as a container
#    for objects, it's called a namespace).

# Example of 1:
# module Study
# end

# class MyClass
#   include Study
# end

# my_obj = MyClass.new

# Example of 2:
# module Study
# end

# Module Outer
#   class MyClass
#     include Study
#   end
# end

# my_obj = Outer::MyClass.new


