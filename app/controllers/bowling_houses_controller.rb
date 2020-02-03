class BowlingHousesController < ApplicationController
  before_action :authorize_request

  def index
    @bowling_houses = @current_admin.bowling_houses

    render json: @bowling_houses
  end

  def create
    @bowling_house = @current_admin.bowling_houses.build(bowling_house_params)

    if @bowling_house.save
      render json: @bowling_house, status: :created
    else
      render json: { errors: @bowling_house.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def bowling_house_params
    params.require(:bowling_house).permit(:name)
  end
end
