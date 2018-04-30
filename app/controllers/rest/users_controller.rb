class Rest::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: :verify_user
  def index
    @users = User.all
    render json: @users
  end
  def verify_user
    storage = @user.image
    post = params[:image]
    percent = User.verify_string_images(storage, post)

    if percent < 0.10
      render json: {message: "OK"}, status: :ok
    else
      render json: {message: "No Autorizado"}, status: :unauthorized
    end
  end
  private
    def set_user
      @user = User.find_by(mail: params[:mail])
    end
end
