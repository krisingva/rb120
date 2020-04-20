class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

p BadDog.new(2, "bear")
# => #<BadDog:0x00007f8b7d9451a0 @name="bear", @age=2>