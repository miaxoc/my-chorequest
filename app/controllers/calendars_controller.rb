class CalendarsController < ApplicationController

  def show
    @all_calendar_tasks = current_user.household.submissions.where(deadline: Date.today.beginning_of_month..Date.today.next_month.end_of_month)
  end

end
