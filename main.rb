class MasterMind
  def initialize
    puts "Welcome! Please enter your name."
    @user = gets.chomp
    puts "Hello #{@user}! Lets play Mastermind."
    @computer = "Computer"
    @numbers = [1, 2, 3, 4, 5, 6]
    @guesses = 12
  end
  
  #private
  def create_code
    secret_code = []
    4.times do
        num = rand(0..5)
        secret_code.push(@numbers[num])
    end
    puts secret_code
  end
end

game = MasterMind.new
game.create_code