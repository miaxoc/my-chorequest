class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @household = @user.household
    @users = @household.users
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @users = User.all
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_param
    params.require(:user).permit(:household)
  end
end
