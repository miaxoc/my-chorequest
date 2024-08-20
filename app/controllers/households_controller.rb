class HouseholdsController < ApplicationController
  def show
    @household = Household.find(params[:id])
    #user show
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
end
