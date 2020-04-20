# Let's add a to_s method to the class:

class Person
  attr_accessor :first_name, :last_name

  def initialize(fn, ln='')
    @first_name = fn
    @last_name = ln
  end

  def name
    if @last_name != ''
      @first_name + " " + @last_name
    else
      @first_name
    end
  end

  def name=(full_n)
    name_arr = full_n.split
    @first_name = name_arr[0]
    @last_name = name_arr[1] if name_arr.size > 1
  end

  def to_s
    name
  end
end

# Now, what does the below output?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# => "The person's name is: Robert Smith"