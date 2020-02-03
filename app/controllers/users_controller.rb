class UsersController < ApplicationController
  before_action :authorize_request

  def index
    @users = User.all.order(nickname: :asc)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname)
  end
end
