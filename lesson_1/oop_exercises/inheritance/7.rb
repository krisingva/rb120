# Create a class 'Student' with attributes name and grade. Do NOT make the grade
# getter public, so joe.grade will raise an error. Create a better_grade_than?
# method, that you can call like so...

class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade_getter > other_student.grade_getter
  end

  protected

  def grade_getter
    @grade
  end
end

p joe = Student.new("Joe", 97)
p bob = Student.new("Bob", 87)
# p joe.grade
p joe.better_grade_than?(bob)
