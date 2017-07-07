require "pry"
require 'random-word'
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
        puts "You got #{@count} wrong so far."
        end
      progress_check
    end

    def progress_check

      if @count >= 5
        puts "You Lose!"
        puts @word
        @loss_count += 1
        puts "Wins: #{@win_count} Losses: #{@loss_count}"
        create_word
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
