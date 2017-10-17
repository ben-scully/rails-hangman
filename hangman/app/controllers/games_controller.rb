class GamesController < ApplicationController
  before_action :find_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show
  end

  def new
    @game = Game.new
  end

  # TODO remove not required
  def edit
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  # TODO remove not required
  def update
    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  # TODO remove not required
  def destroy
    @game.destroy

    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:secret_word)
  end

  def find_game
    @game ||= Game.find(params[:id])
  end
end
