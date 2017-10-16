class GuessesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @guess = @game.guesses.create(guess_params)

    if !@guess.valid?
      flash[:error] = @guess.errors.full_messages
    end

    redirect_to game_path(@game)
  end

  private
    def guess_params
      params.require(:guess).permit(:letter)
    end
end
