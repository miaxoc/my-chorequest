class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def fetch_notifications

    @completed_submissions = Submission.where(status: "completed")

    respond_to do |format|
      format.js
    end
  end
end
