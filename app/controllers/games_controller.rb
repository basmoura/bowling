class GamesController < ApplicationController
  before_action :authorize_request
  before_action :set_lane

  def index
    @games = @lane.games
  end

  def create
    @game = @lane.games.build(game_params)

    if @game.save
      render json: @game, status: :created
    else
      render json: { errors: @game.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    @game = @lane.games.find(params[:id])

    if @game.update(game_params)
      render json: @game, status: :created
    else
      render json: { errors: @game.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def set_lane
    bh = @current_admin.find_bowling_house_by_lane(params[:lane_id])
    @lane = bh.lanes.find(params[:lane_id])
  end

  def game_params
    params.require(:game).permit(:start_at, :end_at, :status)
  end
end
