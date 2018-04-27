class Rest::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: :verify_user
  def index
    @users = User.all
    render json: @users
  end
  def verify_user
    if @user
      a = @user.image
      b = params[:image]
      length = [a.size, b.size].max
      same = a.each_char.zip(b.each_char).select { |origin, request| origin == request}.size
      percent = (length - same) / a.size.to_f
      if percent.round(2) >= 0.90
        render json: {message: "OK #{percent.round(2)}"}, status: :ok
      else
        render json: {message: "No Autorizado #{percent} #{a.size}"}, status: :not_found
      end
    else
      render json: {message: "No Autorizado"}, status: :not_found
    end
  end
  private
  def set_user
    @user = User.find_by(mail: params[:mail])
  end
end
