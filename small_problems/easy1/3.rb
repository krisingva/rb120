# Fix the Program - Books (Part 1)
# Complete this program so that it produces the expected output:

# class Book
#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
# for `book.title` and `book.author` to work, we need a getter method for both
# `title` and `author`
puts %(book = #{book}.)

# Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration
# What are the differences between attr_reader, attr_writer, and attr_accessor?
# Why did we use attr_reader instead of one of the other two? Would it be okay
# to use one of the others? Why or why not?

# Answer: attr_accessor would also work because it would create both a getter
# and a setter method but attr_writer would not work, it would only create a
# setter method.

# Instead of attr_reader, suppose you had added the following methods to this
# class:

# def title
#   @title
# end

# def author
#   @author
# end
#   Would this change the behavior of the class in any way? If so, how? If not,
#   why not? Can you think of any advantages of this code?

# Answer: This is another way of creating a getter method for both `title` and
# `author`, so it should work in the same way as my solution. I think they are
# equivalent, don't see any advantages to this code.


