# Which of the following are objects in Ruby? If they are objects, how can you
# find out what class they belong to?

true
"hello"
[1, 2, 3, "happy days"]
142

# They are all objects, use object.class

p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class

# =>
# TrueClass
# String
# Array
# Integer