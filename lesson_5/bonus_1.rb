# def joinor(arr, separator = ", ", word = "or")
#   if arr.size == 2
#     arr[0].to_s + " " + word + " " + arr[1].to_s
#   elsif arr.size > 2
#     arr[0..-2].join(separator) + separator + word + " " + arr[-1].to_s
#   else
#     arr.join
#   end
# end

def joinor(arr, sep = ", ", word = "or")
  if arr.size == 2
    "#{arr[0]} #{word} #{arr[1]}"
  elsif arr.size > 2
    "#{arr[0..-2].join(sep) + sep + word} #{arr[-1]}"
  else
    arr.join
  end
end

p joinor([1, 2])                   #== "1 or 2"
p joinor([1, 2, 3])                #== "1, 2, or 3"
p joinor([1, 2, 3], '; ')          #== "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   #== "1, 2, and 3"
p joinor([1])
p joinor([])