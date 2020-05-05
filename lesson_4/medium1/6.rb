# If we have these two methods:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# Answer:
def create_template
  @template = "template 14231"
end
# and
def create_template
  self.template = "template 14231"
end
# work the same way, both are using the setter method for the `@template`
# variable that was created using `attr_accessor :template`. However, in the
# first case, we are calling the `@template` variable directly but in the second
# case, we are calling `object.template` which uses the getter method to access
# the variable `@template`
def show_template
  template
end
# and
def show_template
  self.template
end
# both work to access the variable `@template`. In the first case, we are
# calling the getter method for `@template` with the line `template`. This is an
# instance method so the method was already called on an object associated with
# an `@template` variable. In the second case, the `self` in `self.template` is
# excessive since the method is already being called on an object but it will
# not change the execution of the program.

# LS: There's actually no difference in the result, only in the way each example
# accomplishes the task. Compare both show_template methods. We can see in the
# first example that it works fine without self, therefore, self isn't needed in
# the second example. This is because show_template invokes the getter method
# template, which doesn't require self, unlike the setter method.

# Both examples are technically fine, however, the general rule from the Ruby
# style guide is to "Avoid self where not required."
