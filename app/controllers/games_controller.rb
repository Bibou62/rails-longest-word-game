require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @user_input = params[:word]
    url = "https://dictionary.lewagon.com/#{@user_input}"
    word_serialized = URI.parse(url).read
    word = JSON.parse(word_serialized)
    is_english = word['found'] # va stocker un boolean

    @grid = params[:grid]
    in_the_grid = @user_input.chars.all? { |letter| @user_input.count(letter) <= @grid.count(letter) }

    if in_the_grid
      if is_english
        @result = "CONGRATULATIONS! #{@user_input} is a valid English word and in the grid"
      else
        @result = "Sorry but #{@user_input} does not seem to be a valid English word"
      end
    else
      @result = "Sorry but #{@user_input} cant' be build out of grid"
    end
  end
end
