class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.order(:id)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    uploaded_io = user_params[:image]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    file_contents = open("./public/uploads/#{uploaded_io.original_filename}") {|f| f.read}
    @user.image = Base64.encode64(file_contents)
    if @user.save
      flash[:notice] = 'Usuario creado exitosamente.'
      redirect_to users_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Datos de Usuario actualizados.'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'Usuario eliminado de la base de datos'
    redirect_to users_path
  end
  private
  def set_user
    @user = User.find_by_id(params[:id])
  end
  def user_params
    params.require(:user).permit(:mail, :image)
  end
end
