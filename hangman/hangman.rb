require "pry"
gem 'random-word', '~> 1.3'

class Hangman

  def initialize
    @count = 0
    @win_count = 0
    @loss_count = 0
    @game_over = 0

    create_word
  end

    def create_word
      @count = 0
      @word = RandomWord.nouns.next
      template = "_"* @word.length
      @progress = template.chars
      @game_over = 0
      prompt
    end

    def prompt
      display
      puts "Guess a character a-z!"
      guess = gets.chomp
      play(guess)
    end

    def play(guess)
      flag = 0
      @word.chars.each_with_index do |letter, index|
          if letter == guess
            @progress[index] = letter
            flag = 1
          end
      end
        if flag == 0
        @count += 1
        end
      progress_check
    end

    def progress_check

      if @count >= 5
        puts "You Lose!"
        @loss_count += 1
        create_word
        display
      elsif @progress.join == @word
        puts "You Win!"
        @win_count += 1
        display
        create_word
      else
        prompt
      end
    end


    def display
      print  @progress.join
      puts
    end


end
Hangman.new
