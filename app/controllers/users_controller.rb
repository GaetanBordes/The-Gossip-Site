class UsersController < ApplicationController
  before_action :set_user, only: [:show] # Appelle set_user avant l'action show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User was successfully created."
    else
      render :new
    end
  end

  def show
    unless @user
      redirect_to users_path, alert: "User not found."
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id]) # Utilise find_by pour éviter une erreur si l'utilisateur n'existe pas
  end

  def user_params
    params.require(:user).permit(:username, :email, :city, :birth_date, :description, :password, :password_confirmation)
  end
end
