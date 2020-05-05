def validate_age(age)
  raise("invalid age") unless (0..105).include?(age)

  begin
    validate_age(age)
  rescue RuntimeError => e
    puts e.message
  end
end

validate_age(200)

