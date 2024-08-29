class GardensController < ApplicationController
  before_action :set_user

  def show
    @users = current_user.household.users
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
