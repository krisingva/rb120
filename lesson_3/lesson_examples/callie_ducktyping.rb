class Horse
  def speak
    'Neigh'
  end
end

class Dog
  def speak
    'Dog'
  end
end

class Cat
  def speak
    'Meow'
  end
end

class Bird
  def speak
    'Tweet'
  end
end

all_animals = [Horse.new, Dog.new, Cat.new, Bird.new]


all_animals.each do |animal|
  puts animal.speak
end