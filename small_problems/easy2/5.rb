# What Will This Do?
# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
# initializes a new object, @data is initialized and points to 'Hello'
puts Something.dupdata
# class method called, outputs:
'ByeBye'
puts thing.dupdata
# instance method called, output:
'HelloHello'