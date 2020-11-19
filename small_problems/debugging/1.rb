# Community Library
# On line 42 of our code, we intend to display information regarding the books
# currently checked in to our community library. Instead, an exception is
# raised. Determine what caused this error and fix the code so that the data is
# displayed as expected.

class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

# community_library.books.display_data

# Answer: `community_library.books` will return an array where each item is a
# book in the library. The `display_data` method is an instance method for the
# `Book` class, it can only be called on an object of the `Book` class. The code
# as it stands will produce a NoMethod error. In order to fix the code and
# output each book, we would have to iterate through the array and call
# `display_data` on each item.
# Fixed line:
community_library.books.each { |book| book.display_data }

# LS:
# In `Library` class:
# def display_books
#   books.each do |book|
#     book.display_data
#   end
# end
# Then call:
# community_library.display_books
# If this is something we are likely to do often, we can implement a method in
# the `Library` class that does this, as shown with `display_books` in the
# solution above. This would also allow us to later make `@books` invisible to
# the outside, in case we decide that all actions on books should be possible
# only through some `Library` method.
