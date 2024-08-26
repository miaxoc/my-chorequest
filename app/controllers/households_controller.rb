class HouseholdsController < ApplicationController
  def show
    @user = current_user
    @household = @user.household
    @users = @household.users
    @tasks = @household.tasks.order(created_at: :desc)
    @task = Task.new
    @members = User.all

    @my_calendar_tasks = current_user.submissions.where(deadline: Date.today.beginning_of_month..Date.today.next_month.end_of_month)
    @all_calendar_tasks = current_user.household.submissions.where(deadline: Date.today.beginning_of_month..Date.today.next_month.end_of_month)
  end

  def new
    @household = Household.new
    @users = User.all
  end

  def create
    @household = Household.new(household_params)
    @household.user = current_user

    User.all.each do |user|
      user.household = @household
      user.save
    end

    if @household.save
      redirect_to household_path(@household), notice: 'Household was successfully created.'
    else
      @users = User.all
      render :new
    end
  end

  def edit
    @user = current_user
    @household = @user.household
  end

  def update
    @user = current_user
    @household = @user.household
    if @household.update(household_params)
      redirect_to household_path
    else
      render 'household/form', status: :unprocessable_entity
    end
  end

  def destroy

  end

  def timetable
    @household = Household.find(params[:id])
    TimetableService.new(@household).call
    redirect_to household_path(@household)
  end

  def tasks_for_date
    @household = current_user.household
    selected_date = Date.parse(params[:date])
    @tasks_for_date = @household.submissions.where(deadline: selected_date.all_day)
    respond_to do |format|
      format.html { render partial: 'tasks_for_date', locals: { tasks: @tasks_for_date } }
    end
  end

  private

  def household_params
    params.require(:household).permit(:title)
  end

end
