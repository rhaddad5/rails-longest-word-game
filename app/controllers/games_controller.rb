require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    return @letters
  end

  def score
    @letters = params["letters"]
    @new_word = params["word"]
    url = "https://wagon-dictionary.herokuapp.com/#{@new_word}"
    words_serialized = open(url).read
    words = JSON.parse(words_serialized)
    @score = 0
    if !included?(@letters.upcase.split(" "), @new_word.upcase.split(""))
     @answer = "This word does not include letters from the grid"
    elsif !words["found"]
      @answer ="This word does not exist"
    else
      @answer = "Your word: #{@new_word}"
      @answer2 = "Time Taken to answer:"
      @answer3 = "Your score:"
    end
  end

  private

  def included?(grid, attempt)
  attempt.all? do |letter|
    attempt.count(letter) <= grid.count(letter)
    end
  end

end
