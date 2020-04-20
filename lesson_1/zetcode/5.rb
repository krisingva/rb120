x = 35
y = 0

begin
    z = x / y
    puts z
rescue => e
    puts e
    # => divided by 0
    p e
    #<ZeroDivisionError: divided by 0>
end