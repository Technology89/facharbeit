class UsersController < ApplicationController
  before_action :require_signin
  before_action :set_user, only: [ :edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url, notice: "#{@user.name.capitalize} wurde erfolgreich erstellt"
    else
      render :new
    end
  end
 
  def update
    if @user.update(user_params)
      redirect_to users_url, notice: "Passwort für #{@user.name.capitalize} wurde erfolgreich geändert"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user
      session[:user_id] = nil
    end
    user = @user
    @user.destroy
    redirect_to users_url, notice: "#{user.name.capitalize} wurde erfolgreich entfernt"          
  end

  private
    def require_correct_user
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password)
    end
end
