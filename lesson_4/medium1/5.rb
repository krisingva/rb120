# You are given the following class that has been implemented:

# class KrispyKreme
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end
# end

# class KrispyKreme
#   attr_reader :filling_type, :glazing

#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end

#   def to_s
#     if filling_type == nil && glazing == nil
#       "Plain"
#     elsif filling_type == nil
#       "Plain with #{glazing}"
#     elsif glazing == nil
#       "#{filling_type}"
#     else
#       "#{filling_type} with #{glazing}"
#     end
#   end
# end


class KrispyKreme
  attr_reader :filling_type, :glazing
  attr_writer :filling_type

  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
    set_filling if filling_type == nil
  end

  def set_filling
    self.filling_type = "Plain"
  end

  def to_s
    if glazing == nil
      "#{filling_type}"
    else
      "#{filling_type} with #{glazing}"
    end
  end
end

# And the following specification of expected behavior:

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
#  => "Plain"

puts donut2
#  => "Vanilla"

puts donut3
#  => "Plain with sugar"

puts donut4
#  => "Plain with chocolate sprinkles"

puts donut5
#  => "Custard with icing"

# Write additional code for KrispyKreme such that the puts statements will work
# as specified above.

# LS:
# We need to define the to_s method for the class, and then have logic that can
# synthesize the name based on the combinations of filling and glazing.

# class KrispyKreme
#   # ... keep existing code in place and add the below...
#   def to_s
#     filling_string = @filling_type ? @filling_type : "Plain"
#     glazing_string = @glazing ? " with #{@glazing}" : ''
#     filling_string + glazing_string
#   end
# end

# Note that we can choose to create attr_reader directives for the filling and
# glazing instance variables if we want to avoid use of the @ for accessing
# those instance variables and make the to_s easier to read.
