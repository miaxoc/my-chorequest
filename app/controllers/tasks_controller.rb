class TasksController < ApplicationController
  def index
    house = current_user.household
    @users = house.users
    @user = current_user
    @user_tasks = Task.where(user: @user)
    @my_calendar_tasks = current_user.submissions.where(deadline: Date.today.beginning_of_month..Date.today.next_month.end_of_month)

    # Set default to "My Tasks" if no params are provided
    if params[:my_tasks].nil? && params[:calendar].nil?
      params[:my_tasks] = "true"
    end


    # Determine which user to show tasks for

    if params[:my_tasks] == "true"
      @today = Submission.where(user: @user, deadline: Date.today)
      @this_week = Submission.joins(:task).where(user: @user, deadline: Date.today..Date.today.end_of_week, tasks: { frequency: "weekly" })
      @this_month = Submission.joins(:task).where(user: @user, deadline: Date.today..Date.today.end_of_week, tasks: { frequency: "monthly" })
      @submissions = @today + @this_week + @this_month

    # elsif params[:user_id].present?
    #   @user = User.find(params[:user_id])
    #   @user_tasks = Task.where(user: @user)
    #   @submissions = @user.submissions.where(deadline: Date.today)
    elsif params[:calendar] == "true"
      @submissions = @user.submissions
    else
      @user_tasks = Task.where(user: @user)
      @submissions = Submission.where(user: @user)
    end
    total_tasks = @submissions.count
    completed_tasks = @submissions.select{|submission| submission.status == "completed"}.count
    @progress_percentage = if total_tasks > 0
      (completed_tasks.to_f / total_tasks * 100).round(0)
    else
      0
    end

    @task = Task.new
    @submission = Submission.new
  end

  def show
  end

  def new
    @task =  Task.new
  end

  def create
    @task = Task.new(task_params)
    @user = current_user
    @household = current_user.household
    @task.user = @user
    @task.household = @user.household


      if @task.save
        redirect_to chores_household_path(@household)
      else
        redirect_to chores_household_path(@household)
      end
  end



  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to household_path(current_user.household), notice: 'Task was successfully deleted.'
  end

  private

  def task_params
    params.require(:task).permit(:title, :frequency, :category)
  end
end
