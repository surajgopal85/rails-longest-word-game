require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
      'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

    @grid = []
    10.times do
      char = letters[rand(letters.length)]
      @grid << char
    end
  end

  def score
    @answer = params[:answer]
    @presented = params[:token].downcase

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    comparison = URI.open(url).read

    match = true
    chars = @answer.split('')
    p chars
    chars.each do |x|
      unless chars.count(x) <= @presented.count(x)
        match = false
        break
      end
    end

    check = JSON.parse(comparison)
    hit = check["found"]

    if !hit
      @message = "Not a word!"
      @score = 0
    elsif !match
      @message = "Word not in grid!"
      @score = 0
    else
      @message = "GREAT JOB!"
      len = @answer.length
      @score = len**2
    end


  end
end
