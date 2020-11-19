# Wish You Were Here
# On lines 37 and 38 of our code, we can see that `grace` and `ada` are located
# at the same coordinates. So why does line 39 output `false`? Fix the code to
# produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  # fix (can omit self.):
  def ==(other_obj)
    self.longitude == other_obj.longitude && self.latitude == other_obj.latitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

# Answer: `ada.location` and `grace.location` each points to a `GeoLocation`
# object that share the same values for `longitude` and `latitude` but they are
# still two different objects. In order to be able to compare equality of two
# different `GeoLocation` objects based on the values of `longitude` and
# `latitude`, we would have to write a new `comparable` method in the class that
# will override the method in the `BasicObject` superclass:

# def ==(other_obj)
#   self.longitude == other_obj.longitude && self.latitude == other_obj.latitude
# end