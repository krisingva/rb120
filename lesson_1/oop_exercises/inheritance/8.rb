# Given the following code...

# bob = Person.new
# bob.hi

# And the corresponding error message...

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?

# Answer:
# Problem: The method `hi` was defined after the keyword `private` in the
# `Person` class.
# Fix: Move the method definition for `hi` above the `private` keyword