class AuthController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @admin = Admin.find_by_email(params[:email])

    if @admin&.authenticate(params[:password])
      token = JwtWrapper.encode(admin_id: @admin.id)
      time = Time.now + 1.month.to_i
      render json: { token: token,
                     exp: time.strftime("%m-%d-%Y %H:%M")
                   }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
