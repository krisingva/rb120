# Start the Engine (Part 2)
# Given the following code, modify #start_engine in Truck by appending 'Drive
# fast, please!' to the return value of #start_engine in Vehicle. The 'fast' in
# 'Drive fast, please!' should be the value of speed.

# class Vehicle
#   def start_engine
#     'Ready to go!'
#   end
# end

# class Truck < Vehicle
#   def start_engine(speed)
#   end
# end

# truck1 = Truck.new
# puts truck1.start_engine('fast')

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# Expected output:

# Ready to go! Drive fast, please!

# LS:
# Discussion
# As we know, #super invokes the method in the inheritance hierarchy with the
# same name as the method in the child. Therefore, #start_engine in Vehicle will
# be invoked if we call #super within #start_engine in Truck. The tricky part
# here is that #start_engine in Vehicle doesn't accept any arguments. If we
# passed speed as an argument, we would get an error. To remedy this, we can
# invoke #super with empty parentheses, which means no arguments will be passed.