# In the last question we had a module called Speed which contained a go_fast
# method. We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

# When we called the go_fast method from an instance of the Car class (as shown
# below) you might have noticed that the string printed when we go fast includes
# the name of the type of vehicle we are using. How is this done?

>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!

# Answer: The `small_car` object of `Car` class can call the instance method `go_fast` after the `Speed` module has been included in the class. The calling object is `small_car` and that is what `self` refers to in the `go_fast` method. Inside the method we call `small_car.class` which gives the class of the object, `Car`. The string interpolation `#{}` will make sure the return of that call is converted to a string and able to be used in the output.