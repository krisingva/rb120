# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

# And another class:

class Bingo
  def rules_of_play
    #rules of play
  end
end

# What can we add to the Bingo class to allow it to inherit the play method from
# the Game class?

# Answer: class Bingo < Game

# LS:
# To test this code out we will need to create a new instance of the class Bingo
# and then call the play method on that instance, as you can see below:

# >> game_of_bingo = Bingo.new
# => #<Bingo:0x007f9d19b537c8>
# >> game_of_bingo.play
# => "Start the game!"
