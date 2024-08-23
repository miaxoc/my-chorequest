class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @household = @user.household
    @users = @household.users
    total_tasks = current_user.submissions.count
    completed_tasks = current_user.submissions.where(status: "completed").count
    @progress_percentage = if total_tasks > 0
      (completed_tasks.to_f / total_tasks * 100).round(2)
    else
      0
    end
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
