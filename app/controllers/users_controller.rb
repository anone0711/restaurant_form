class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  before_action :get_user, only: [:show, :edit, :update]
  def show
    @commented_restaurants = @user.restaurants.uniq
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  private

  def get_user
      @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
