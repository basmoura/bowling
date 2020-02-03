class LanesController < ApplicationController
  before_action :authorize_request
  before_action :set_bowling_house

  def index
    @lanes = @bowling_house.lanes
  end

  def create
    @lane = @bowling_house.lanes.build(lane_params)

    if @lane.save
      render json: @lane, status: :created
    else
      render json: { errors: @lane.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    @lane = @bowling_house.lanes.find(params[:id])

    if @lane.update(lane_params)
      render json: @lane, status: :created
    else
      render json: { errors: @lane.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def set_bowling_house
    @bowling_house = @current_admin.bowling_houses
                                   .find(params[:bowling_house_id])
  end

  def lane_params
    params.require(:lane).permit(:status)
  end
end
