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
  end

  def create
    @household = Household.new(household_params)
    if @household.save
      redirect_to households_path(@household)
    else
      render '/households/new', status: :unprocessable_entity
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

  private

  def household_params
    params.require(:household).permit(:title)
  end

end
