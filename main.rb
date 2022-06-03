class MasterMind
    def initialize
      puts "Welcome! Please enter your name."
      @user = gets.chomp
      puts "Hello #{@user}! Lets play Mastermind."
      puts "Would you like to be the Codebreaker or Codemaker?\nEnter 1 for breaker, 2 for maker"
      @user_job = gets.chomp.to_i #add exception handling to make sure either 1 or 2 was entered
      @numbers = [1, 2, 3, 4, 5, 6]
      @secret_code = []
      @secret_code_immutable = []
      @guesses_left = 12
      @guess = nil
      @feedback = []
      @winner = 0
    end
    
    private
    def create_code
      4.times do
          num = rand(0..5)
          @secret_code.push(@numbers[num])
          @secret_code_immutable.push(@numbers[num])
      end
    end

    public #change to priv
    def user_created_code
      begin
        puts "Enter your 4 digit secret code.\nCode must be four numbers 1-6 with a space between numbers (ex. 2 4 6 2)."
        @secret_code = gets.chomp.split()
        @secret_code.map! { |number| number.to_i}
        @secret_code.each { |number| @secret_code_immutable.push(number)}
        if @secret_code.length != 4 || @secret_code[0] > 6 || @secret_code[0] < 1 || @secret_code[1] > 6 || @secret_code[1] < 1 || @secret_code[2] > 6 || @secret_code[2] < 1 || @secret_code[3] > 6 || @secret_code[3] < 1
            raise 'Error'
        end
      rescue
        puts "Invalid entry."
        retry
      else
        puts "Your secret code is #{@secret_code}"
      end
    end

    public #change to priv
    def computer_guess
      available_indexes = [0, 1, 2, 3]
      if @guess == nil #first comp guess
        @guess = [1, 1, 2, 2]
      else  #any guess other than first guess
        @feedback.each_with_index do |number, index|
          if number == 2 #exactly right
            #push num from previous guess to new guess
            @guess[index] = @guess[index]
            available_indexes.delete(index)
          elsif number == 1 #righ num wrong place
            #use num from previous guess in different position
            @guess[(available_indexes.sample)] = @guess[index]
          else #wrong number
            #Don't use that number again in guesses
            @numbers.delete(@guess[index])
            #use other possible number in that position
            @guess[index] = @numbers.sample
          end
        end
      end
      puts "The computer guessed: #{@guess}"
      @guesses_left -=1
      @feedback = []
    end

    private
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
  
    private
    def check_guess
      @feedback = [] 
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
      @secret_code = []
      @secret_code_immutable.each { |num| @secret_code.push(num) }
    end
  
    private
    def give_feedback
      exactly_correct = 0
      right_num_wrong_spot = 0
      @feedback.each do |number|
          if number == 2
              exactly_correct += 1
          elsif number == 1
              right_num_wrong_spot += 1
          end
      end

      puts "The guess contains:\n#{exactly_correct} Exactly correct\n#{right_num_wrong_spot} Right number, wrong position\n#{@guesses_left} Guesses left"
      if exactly_correct == 4
          @winner = 1
          puts "The secret code was guessed! Codebreaker wins!"
      end
    end
  
    public
    def play_game
      if @user_job == 1
        puts "You are the Codebreaker, good luck!"
        create_code
        while @winner == 0
            if @guesses_left == 0
              puts "No guesses left! Computer wins!\nSecret Code was #{@secret_code}"
              break
            end
            make_guess
            check_guess
            give_feedback
        end
        puts "GAME OVER"
      elsif @user_job ==2
        puts "You are the Codemaker!\nLets see how smart this computer is..."
        user_created_code
        while @winner == 0
            if @guesses_left == 0
                puts "No guesses left! #{@user} wins!"
                break
            end
            computer_guess
            check_guess
            give_feedback
        end
        puts "GAME OVER"
      end
    end
  end
  
  game = MasterMind.new
  game.play_game