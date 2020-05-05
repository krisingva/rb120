# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know?
# Answer: `self.manufacturer` is a class method (prefixed by `self.`)
# How would you call a class method?
# Answer: ClassName.method_name
# Here: Television.manufacturer