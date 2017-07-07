
def hangman


  def create_word
    word = "hangman"
    template = "_"*word.length
  end
  def prompt
    puts "Guess a character a-z!"
    guess = gets.chomp
  end
  count = 0
  progress = template.chars

  def play
    word.chars.each_with_index do |letter, index|
    if letter == guess
      progress[index] = letter
    else
        count += 1
    end

    if count == 5
      puts "You Lose!"
    end

    if progress.join == word
      puts "You Win!"
    end
  end


    def display
        progress
    end

end
