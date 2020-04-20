class Rock; end
class Paper; end
class Scissors; end


def get(value)
  hash = {
    'rock' => Rock,
    'paper' => Paper,
    'scissors' => Scissors,
  }
  pick = nil
  hash.each_key do |k|
    pick = hash[k].new if k == value
  end
  p pick
end

get('rock')