class HouseholdsController < ApplicationController
  def show
    @user = current_user
    @household = @user.household
    @users = @household.users
    @tasks = Task.all
  end

  def new
    @household = Household.new
  end

  def create
    @household = Household.new(household_params)
    if @household.save
      redirect_to household_path(@household)
    else
      render 'new', status: :unprosessable_entity
    end
  end

  def edit
    @user = current_user
    @household = @user.household
    if @household.update(household_params)
  end

  def update
  end

  def destroy
  end

  private

  def household_params

  end

end
