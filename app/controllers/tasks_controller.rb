class TasksController < ApplicationController
  def index
    # @submissions = Submission.all

    if params[:all_users] == "true"
      @user_tasks = Task.where(user: current_user.household.users)
      @user = nil
    elsif params[:user_id].present?
      @user = User.find(params[:user_id])
      @user_tasks = Task.where(user: @user)
    else
      @user = current_user
      @user_tasks = Task.where(user: @user)
    end
    house = current_user.household
    @users = house.users

  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def completed_tasks

  end
end
