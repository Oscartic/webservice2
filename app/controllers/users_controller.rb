class UsersController < ApplicationController
  before_action :set_user, only: [:create, :edit, :update, :destroy]

  def index
    @users = User.all.order(:id)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if user_params[:mail] != '' && user_params[:image] != nil
      file_contents = User.image_capture(user_params[:image])
      Rails.logger.info "file_contents" + @user.inspect + " ////////////"
      @user.image = file_contents
      if @user.save
        flash[:notice] = 'Usuario creado exitosamente.'
        redirect_to users_path
      end
    else
      flash[:alert] = 'Error en la creación de usuario. Se requiere que proporcione información de todos los campos.'
      redirect_to users_path
    end
  end

  def update
    if user_params[:image]
      uploaded_io = User.image_capture(user_params[:image])
      @user.update(:mail => user_params[:mail], :image => uploaded_io)
    else
      @user.update(:mail => user_params[:mail])
    end
    flash[:notice] = 'Datos de Usuario actualizados.'
    redirect_to users_path
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
