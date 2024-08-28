class HouseholdsController < ApplicationController
  def show
    @user = current_user
    @household = @user.household
    @users = @household.users || []
    @tasks = @household.tasks.order(created_at: :desc)
    @task = Task.new
    @members = User.all
    @completed_submissions = @household.submissions.where(status: "completed").order(updated_at: :desc)

    @my_calendar_tasks = current_user.submissions.where(deadline: Date.today.beginning_of_month..Date.today.next_month.end_of_month)
    @all_calendar_tasks = current_user.household.submissions.where(deadline: Date.today.beginning_of_month..Date.today.next_month.end_of_month)
  end

  def new
    @household = Household.new
    @users = User.all
  end

  def create
    @household = Household.new(household_params)
    @household.user = current_user

    if @household.save
      # Assign selected users to the household
      selected_users = User.where(id: params[:household][:user_ids])
      selected_users.each do |user|
        user.household = @household
        user.save
      end

      redirect_to household_path(@household), notice: 'Household was successfully created.'
    else
      @users = User.all
      render :new
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
    redirect_to household_calendar_path(@household)
  end

  def search_users
    Rails.logger.debug "Search action called with query: #{params[:query]}"

    if params[:query].present?
      @users = User.where("username LIKE ?", "%#{params[:query]}%")
    else
      @users = User.none
    end

    Rails.logger.debug "Users found: #{@users.pluck(:username)}"

    respond_to do |format|
      format.json { render json: @users.pluck(:id, :username) }
    end
  end

  def chores
    @user = current_user
    @household = @user.household
    @users = @household.users || []
    @tasks = @household.tasks.order(created_at: :desc)
    @task = Task.new
    @members = User.all

  end

  def view_tasks
    @users = User.all
  end

  private

  def household_params
    params.require(:household).permit(:title, user_ids: [])
  end

end
