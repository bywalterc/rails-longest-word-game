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
  end
end
