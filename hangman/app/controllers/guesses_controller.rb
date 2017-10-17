class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    guess = game.guesses.new(guess_params)

    flash[:error] = guess.errors.full_messages unless guess.save

    redirect_to game
  end

  private

  def guess_params
    params.require(:guess).permit(:letter)
  end
end
