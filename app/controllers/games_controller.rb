# require 'open-uri'

class GamesController < ApplicationController
  def new
    universe = ('A'..'Z').to_a
    @letters = []
    10.times do
      item = universe.sample
      @letters << item
    end
  end

  def score
    # raise
    @word = params[:word]
    @selection = params[:selection]
    @answer = if word_in_selection(@word, @selection)
                if word_is_english(@word)
                  "Congratulations! 👍 #{@word.upcase} is an English word!"
                else
                  "Sorry 😟 #{@word.upcase} is not an English word..."
                end
              else
                "Sorry 😟 #{@word.upcase} can't be built out of #{@selection}"
              end
  end

  def word_in_selection(word, selection)
    answer = true
    word_array = word.split('')
    selection_array = selection.split(' ')
    word_array.each do |letter|
      if selection_array.find_index(letter.upcase).nil?
        answer = false
      else
        selection_array.delete_at(selection_array.find_index(letter.upcase))
      end
    end
    answer
  end

  def word_is_english(word)
    url = 'https://wagon-dictionary.herokuapp.com/' + word
    response = HTTParty.get(url)
    answer_hash = JSON.parse(response.body)
    answer = answer_hash['found']
    answer
  end
end

