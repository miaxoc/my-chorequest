class CalendarController < ApplicationController

  def show
    @household = current_user.household
  end

end
