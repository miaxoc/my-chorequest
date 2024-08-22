class TimetableService
  def initialize(household)
    @household = household
    @users = household.users.to_a
  end

  def call
    tasks = @household.tasks
    daily_tasks = tasks.where(frequency: "daily")
    weekly_tasks = tasks.where(frequency: "weekly")
    monthly_tasks = tasks.where(frequency: "monthly")

      # Daily tasks
    distribute_daily_tasks(daily_tasks)

    # Weekly tasks
    distribute_weekly_tasks(weekly_tasks)

    # Monthly tasks
    distribute_monthly_tasks(monthly_tasks)
  end

  private

  def distribute_daily_tasks(daily_tasks)
    dates = (Date.today..Date.today.next_month.end_of_month)
    user_index = 0

    daily_tasks.each do |task|
      dates.each do |date|
        Submission.create({
          status: date.past? ? ["completed", "completed", "completed", "given"].sample : "given",
          task: task,
          user: @users[user_index], # Assign the task to the user
          deadline: date
        })

        # Cycle to the next user
        user_index = (user_index + 1) % @users.length
      end
    end
  end

  def distribute_weekly_tasks(weekly_tasks)
    user_index = 0

    sundays = (Date.today..Date.today.next_month.end_of_month).select { |day| day.wday.zero? }

    weekly_tasks.each do |task|
      sundays.each do |sunday|
        Submission.create({
          status: "given",
          task: task,
          user: @users[user_index], # Assign the task to the user
          deadline: sunday
        })

        # Cycle to the next user
        user_index = (user_index + 1) % @users.length
      end
    end
  end

  def distribute_monthly_tasks(monthly_tasks)
    user_index = 0

    monthly_tasks.each do |task|
      Submission.create({
        status: "given",
        task: task,
        user: @users[user_index], # Assign the task to the user
        deadline: Date.today.end_of_month
      })

      # Cycle to the next user
      user_index = (user_index + 1) % @users.length
    end
  end
end
