# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer
# => NoMethodError, `manufacturer` is a class method, cannot be called on an
# instance of the class, only on the class itself
tv.model
# => method implemented, `model` is an instance method

Television.manufacturer
# => method implemented, `manufactuer` is a class method
Television.model
# => NoMethodError, `model` cannot be called on the class itself, only on
# instance of the class