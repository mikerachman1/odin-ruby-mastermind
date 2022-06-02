class MasterMind
  def initialize
    puts "Welcome! Please enter your name."
    @user = gets.chomp
    puts "Hello #{@user}! Lets play Mastermind. Try to guess the 4 number secret code in under 12 rounds. Code numbers are 1-6 (ex: 1 1 6 4)"
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
  end

  #private
  def make_guess
    begin
      puts "Enter your guess."
      guess = gets.chomp.split()
      guess.map! { |value| value.to_i }
      if guess.length != 4 || guess[0] > 6 || guess[0] < 1 || guess[1] > 6 || guess[1] < 1 || guess[2] > 6 || guess[2] < 1 || guess[3] > 6 || guess[3] < 1
        raise 'Error' 
      end    
    rescue
      puts "Invalid entry.\nRe-enter a four number guess.\nGuess must be four numbers 1-6 with a space between numbers (ex. 2 4 6 2)."
      retry
    else
        @guesses -= 1
        puts guess
    end
  end

end

game = MasterMind.new
game.create_code
game.make_guess