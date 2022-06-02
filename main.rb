class MasterMind
  def initialize
    puts "Welcome! Please enter your name."
    @user = gets.chomp
    puts "Hello #{@user}! Lets play Mastermind."
    @computer = "Computer"
    @numbers = [1, 2, 3, 4, 5, 6]
    @guesses = 12
  end

end

game = MasterMind.new
game