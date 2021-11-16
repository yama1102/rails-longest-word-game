require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:word].upcase.split('')
    grid = params[:letters].split('')

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word].downcase}"
    buffer = open(url).read
    json = JSON.parse(buffer)

    if word.all? { |element| grid.include?(element) }
      if json["found"]
        @result = "Congratulation! #{params[:word].upcase} is valid English word!"
      else
        @result = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{params[:word].upcase} can't be built out of #{grid.join(', ')}"
    end
  end
end
