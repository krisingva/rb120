class Animal
  def eat
    # generic eat method
    "Animal eating"
  end
end

class Fish < Animal
  def eat
    # eating specific to fish
    "Fish eating"
  end
end

class Cat < Animal
  def eat
     # eat implementation for cat
     "Cat eating"
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Cat.new]
array_of_animals.each do |animal|
  puts animal
  puts feed_animal(animal)
end

# =>
# #<Animal:0x00007fa4f49588c8>
# Animal eating
# #<Fish:0x00007fa4f49588a0>
# Fish eating
# #<Cat:0x00007fa4f4958878>
# Cat eating