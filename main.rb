class MasterMind
  def initialize
    puts "Welcome! Please enter your name."
    @user = gets.chomp
    puts "Hello #{@user}! Lets play Mastermind.\nTry to guess the 4 number secret code in under 12 rounds.\nCode numbers are 1-6 (ex: 1 1 6 4)"
    @computer = "Computer"
    @numbers = [1, 2, 3, 4, 5, 6]
    @secret_code = []
    @secret_code_immutable = []
    @guesses_left = 12
    @guess = nil
    @feedback = []
  end
  
  #private
  def create_code
    4.times do
        num = rand(0..5)
        @secret_code.push(@numbers[num])
        @secret_code_immutable.push(@numbers[num])
    end
  end

  #private
  def make_guess
    begin
      puts "Enter your guess."
      @guess = gets.chomp.split()
      @guess.map! { |value| value.to_i }
      if @guess.length != 4 || @guess[0] > 6 || @guess[0] < 1 || @guess[1] > 6 || @guess[1] < 1 || @guess[2] > 6 || @guess[2] < 1 || @guess[3] > 6 || @guess[3] < 1
        raise 'Error' 
      end    
    rescue
      puts "Invalid entry.\nRe-enter a four number guess.\nGuess must be four numbers 1-6 with a space between numbers (ex. 2 4 6 2)."
      retry
    else
        @guesses_left -= 1
    end
  end

  #private
  def check_guess #PROBLEM WITH MULTIPLES AND INDEXING
    @guess.each_with_index do |number, index|
      if @secret_code[index] == number # matches both number and position
        @feedback.push(2)
        @secret_code[index] = nil
      elsif @secret_code.include?(number) # matches number in code
        @feedback.push(1)
        @secret_code[(@secret_code.index(number))] = nil
      else # no match
        @feedback.push(0)
      end
    end
    @secret_code = @secret_code_immutable
  end

end

game = MasterMind.new
game.create_code
game.make_guess
game.check_guess