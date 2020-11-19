# https://launchschool.com/books/oo_ruby/read/inheritance#exercises

# Create a class 'Student' with attributes name and grade. Do NOT make the grade
# getter public, so joe.grade will raise an error. Create a better_grade_than?
# method, that you can call like so...


class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    grade > other.grade
  end

  protected

  attr_reader :grade
end

joe = Student.new("joe", 95)
bob = Student.new("bob", 70)
puts "Well done!" if joe.better_grade_than?(bob)