class Example
  attr_reader :something
  def initialize
    @something = ['a', 'b', 'c']
  end
  def print_something
    if something.size == 0
      puts "something has just 1 item: #{something[0]}"
    elsif something.size == 1
      puts "something has 2 items: #{something[0]} #{something[1]}"
    else
      puts "something has #{something.size} items: #{something.join(' ')}"
    end
  end
end

example = Example.new
example.print_something
# rubocop offense:
# Metrics/AbcSize: Assignment Branch Condition size for print_something is too
# high. [19.1/18]  (http://c2.com/cgi/wiki?AbcMetric)
# 19 branches and 2 conditions
# 7 calls to `something` getter method
# Fix: use `@something` directly or save `something` to a local variable