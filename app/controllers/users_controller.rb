class UsersController < ApplicationController
  def index
    @users = User.all.order(:id)
  end

  def create
  end

  def update
  end

  def destroy
  end
end
