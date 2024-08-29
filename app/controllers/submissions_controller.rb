class SubmissionsController < ApplicationController
  def index
  end

  def new
    @submission = Submission.new
  end

  def edit
    @user = current_user

    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    if current_user != @submission.user
      redirect_to tasks_path, notice: 'You are not the task owner'
      return
    end



    if @submission.update(submission_params)
      sleep(1)
      redirect_to tasks_path(frequency: params[:frequency])
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def submission_params
    params.require(:submission).permit(:status, :photo)
  end




end
