require "open-uri"

class GamesController < ApplicationController

  # Method to make a random array of letters on start screen
  def new
    @letters = []
    @letters += ("A".."Z").to_a.sample(10)
    return @letters
  end

  def score
    @userinput = params[:userinput].upcase # with .chars "do" => DO => ["D", "O"]
    @letterlist = params[:letters] # => "T P G O J S W K N F"
    @letters = params[:letters].split # => ["T", "P", "G", "O", "J", "S", "W", "K", "N", "F"]

    if !gridword?(@userinput)
      @outcome = "Invalid input: the word can't be built out of the original grid. Try again."

    elsif !englishword?(@userinput)
      @outcome = "Invalid input: not a valid English word. Try again."

    else
      @outcome = "Great word, good job!"
    end

  end

  private

  def gridword?(input)
    input.chars.all? { |letter| @letters.include?(letter) }  # returns true or false
  end

  def englishword?(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    url_converted = URI.open(url).read
    word = JSON.parse(url_converted)
    word["found"] # returns true or false
  end

end
