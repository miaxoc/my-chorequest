class SubmissionsController < ApplicationController
  def index
  end

  def show
  end

  def new
    # @tasks = current_user.tasks
    # user = User.find(params[:user_id])
    # @user_tasks = user.tasks
    @tasks = Task.all
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

  # def submission_params
  #   params.require(:submission).permit(:status, :photo)
  # end
end
