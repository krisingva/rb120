class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members << person
  end
end

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def ==(other)
    name == other.name  # relying on String#== here
  end

  def >(other_person)
    age > other_person.age
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)
# suppose we're using the Person class from earlier

cowboys << emmitt
# will this work?

p cowboys.members
# => [#<Person:0x00007f81bf04bd28 @name="Emmitt Smith", @age=46>]