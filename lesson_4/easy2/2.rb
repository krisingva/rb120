# We have an Oracle class and a RoadTrip class that inherits from the Oracle
# class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
p trip.predict_the_future

# The question is, will the `choices` method from the `Roadtrip` class be
# executed or the one from the `Oracle` class? Once you are in a method defined
# in a superclass, will another method call for a method name consistent with
# methods both in super- and sub-class be directed at the current class
# (superclass) or the calling object's class (subclass)?

# My answer: calling object's class method

# LS:
# Since we're calling predict_the_future on an instance of RoadTrip, every time
# Ruby tries to resolve a method name, it will start with the methods defined on
# the class you are calling. So even though the call to choices happens in a
# method defined in Oracle, Ruby will first look for a definition of choices in
# RoadTrip before falling back to Oracle if it does not find choices defined in
# RoadTrip. To see this in action, change the name of the choices method in
# RoadTrip (call it chooses) and see what happens.