class HouseholdsController < ApplicationController
  def show
    @user = current_user
    @household = @user.household
    @users = @household.users
    @tasks = Task.all
    @task = Task.new
    @members = User.all
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
  end

  private

  def household_params
    params.require(:household).permit(:title)
  end

end
