# Comparing Wallets
# Consider the following broken code:

# class Wallet
#   include Comparable

#   def initialize(amount)
#     @amount = amount
#   end

#   def <=>(other_wallet)
#     amount <=> other_wallet.amount
#   end
# end

# bills_wallet = Wallet.new(500)
# pennys_wallet = Wallet.new(465)
# if bills_wallet > pennys_wallet
#   puts 'Bill has more money than Penny'
# elsif bills_wallet < pennys_wallet
#   puts 'Penny has more money than Bill'
# else
#   puts 'Bill and Penny have the same amount of money.'
# end

# Modify this code so it works. Do not make the amount in the wallet accessible
# to any method that isn't part of the Wallet class.


class Wallet
  include Comparable
  # attr_reader :amount
  # would make amount reader method public

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  def amount
    @amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end
# => Bill has more money than Penny
p bills_wallet.amount
# =>
# Traceback (most recent call last):
# 6.rb:59:in `<main>': protected method `amount' called for #<Wallet:0x00007f8651060bd8 @amount=500> (NoMethodError)

# LS:

# Solution
# class Wallet
#   ...

#   protected

#   attr_reader :amount
# end

# Discussion
# From the definition of the <=> method, we can see that the current wallet
# object must be able to call the amount getter both in its own context, and in
# the context of other_wallet. The easiest way to do this is to simply provide a
# public getter method for :amount.

# However, the problem description prevents this; nobody should be able to look
# at the amount except another wallet. To do this, we use the Module#protected
# method. A protected method is similar to a private method, except that methods
# of the class can call the protected method of any other object of the same
# class. Thus, bills_wallet can look at pennys_wallet to find the amount.

# Further Exploration
# This example is rather contrived and unrealistic, but this type of situation
# occurs frequently in applications. Can you think of any applications where
# protected methods would be desirable?

# Answer: Could be used to ensure pay equality, if you were able to look whether
# another person performing the same job as you is getting the same salary