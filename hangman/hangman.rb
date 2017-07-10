require "pry"
require 'random-word'
require 'colorize'
# https://rubygems.org/gems/colorize/versions/0.7.7
  # gem 'colorize', '~> 0.7.7'
  # gem install colorize -v 0.7.7

class Hangman

  def initialize
    @count = 0
    @win_count = 0
    @loss_count = 0
    @game_over = 0

    create_word
  end

  def welcome
    puts "First, choose solo or two person mode, default is solo. Then choose difficulty level, which limits wrong choices."
  end

  def create_word
    @count = 0
    @word = RandomWord.nouns.next
    template = "_"* @word.length
    @progress = template.chars
    @game_over = 0
    prompt
  end

  def set_difficulty
    difficulty = nil
    unless  difficulty == "e" || difficulty == "m" || difficulty == "d"
    puts "Select Difficulty: 'e' easy, 'm' moderate, 'd' difficult."
        difficulty = gets.chomp
    end

    if difficulty == "e"
      @tries = 20
    elsif difficulty == "m"
      @tries = 10
    elsif difficulty == "d"
      @tries = 5
    end
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

    if @count >= @tries
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

  #old, working model:
  # def display
  #   print  @progress.join
  #   puts
  # end

  def display
    if @count.to_f/@tries.to_f < .33
    print  @progress.join.green
    puts
  elsif @count.to_f/@tries.to_f > .33 && @count.to_f/@tries.to_f < .66
    print  @progress.join.orange
    puts
  elsif @count.to_f/@tries.to_f > .66
    print  @progress.join.red
  end

end
Hangman.new
