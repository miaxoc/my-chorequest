class TasksController < ApplicationController
  def index
    house = current_user.household
    @users = house.users

    # Determine which user to show tasks for
    if params[:all_tasks] == "true"
      @user = current_user
      @user_tasks = Task.where(user: @user)
      @submissions = Submission.where(user: @user)
    # elsif params[:user_id].present?
    #   @user = User.find(params[:user_id])
    #   @user_tasks = Task.where(user: @user)
    #   @submissions = @user.submissions.where(deadline: Date.today)
    elsif params[:frequency] == "daily"
      @user = current_user
      @user_tasks = Task.where(user: @user)
      @submissions = @user.submissions.where(deadline: Date.today)
    elsif params[:frequency] == "weekly"
      @user = current_user
      @user_tasks = Task.where(user: @user)
      @submissions = @user.submissions.joins(:task).where(deadline: Date.today..Date.today.end_of_week, tasks: { frequency: "weekly" })

    elsif params[:frequency] == "monthly"
      @user = current_user
      @user_tasks = Task.where(user: @user)
      @submissions = @user.submissions.joins(:task).where(deadline: Date.today..Date.today.end_of_month, tasks: { frequency: "monthly" })
    else
      @user = current_user
      @user_tasks = Task.where(user: @user)
      @submissions = Submission.where(user: @user)
    end
    total_tasks = @submissions.count
    completed_tasks = @submissions.where(status: "completed").count
    @progress_percentage = if total_tasks > 0
      (completed_tasks.to_f / total_tasks * 100).round(2)
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
    @task.user = @user
    @task.household = @user.household

    respond_to do |format|
      if @task.save
        format.html { redirect_to household_path(current_user.household), notice: 'Task was successfully created.' }
        format.js   # Handle the AJAX response for the task creation
      else
        format.html { render 'new', status: :unprocessable_entity }
        format.js   # In case of failure, handle the AJAX response
      end
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
