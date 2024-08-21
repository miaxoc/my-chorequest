class User < ApplicationRecord
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :household, optional: true
  has_many :submissions
  has_many :tasks, through: :submissions

  def daily_task_submissions_due_today
    submissions.joins(:task).where(tasks: { frequency: 'daily' }).where(deadline: Date.today)
  end

  def weekly_task_submissions_due_this_week
    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week

    submissions.joins(:task)
               .where(tasks: { frequency: 'weekly' })
               .where(deadline: start_of_week..end_of_week)
  end

  def all_task_submissions_due
    daily = submissions.joins(:task)
                       .where(tasks: { frequency: 'daily' })
                       .where(deadline: Date.today)

    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week

    weekly = submissions.joins(:task)
                        .where(tasks: { frequency: 'weekly' })
                        .where(deadline: start_of_week..end_of_week)
    start_of_month = Date.today.beginning_of_month
    end_of_month = Date.today.end_of_month

    monthly = submissions.joins(:task)
                        .where(tasks: { frequency: 'monthly' })
                        .where(deadline: start_of_month..end_of_month)

    daily.or(weekly).or(monthly)
  end
end
