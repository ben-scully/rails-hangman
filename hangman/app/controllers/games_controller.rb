class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
     @game = Game.find(params[:id])
   end

  def new
    @game = Game.new
  end

  # TODO remove not required
  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      flash[:error] = @game.errors.full_messages
      render 'new'
    end
  end

  # TODO remove not required
  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      flash[:error] = @game.errors.full_messages
      render 'edit'
    end
  end

  # TODO remove not required
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to games_path
  end

  private
    def game_params
      params.require(:game).permit(:secretword, :text)
    end
end
