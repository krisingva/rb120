class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    # create a new object of `Team` class
    temp_team.members = members + other_team.members
    # add members to new `Team` object from the other two teams
    temp_team
    # return new `Team` object
  end
end

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

dream_team = niners + cowboys
puts dream_team.inspect
# =>
##<Team:0x00007fa9cc04ab28 @name="Temporary Team",
#@members=[#<Person:0x00007fa9cc04ada8 @name="Joe Montana", @age=59>,
##<Person:0x00007fa9cc04ac90 @name="Jerry Rice", @age=52>,
##<Person:0x00007fa9cc04abf0 @name="Deion Sanders", @age=47>,
##<Person:0x00007fa9cc04b190 @name="Troy Aikman", @age=48>,
##<Person:0x00007fa9cc04b118 @name="Emmitt Smith", @age=46>,
##<Person:0x00007fa9cc04b078 @name="Michael Irvin", @age=49>]>