class SubmissionsController < ApplicationController
  #---------#
  # click on the "complete"
  # user goes to the update form
  # upload the picture
  # submit

  def index
  end

  def new
    @submission = Submission.new
  end

  def edit
    @submission = Submission.find(params[:id])
    @tasks = Task.where(user_id: current_user.id)
  end

  def update
    @submission = Submission.find(params[:id])
    @submission.user = current_user
    @tasks = Task.where(user_id: current_user.id).where.not(status: 'completed')
    @submission.status = "completed"
    if @submission.save
      redirect_to tasks_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def submission_params
    params.require(:submission).permit(:status, :photo)
  end
end
#---------------------#

# def new
#   @bookmark = Bookmark.new
#   @list = List.find(params[:list_id])
# end

# def create
#   @list = List.find(params[:list_id])
#   @bookmark = Bookmark.new(bookmark_params)
#   @bookmark.list = @list
#   if @bookmark.save
#     redirect_to list_path(@list)
#   else
#     render 'new', status: :unprocessable_entity
#   end
# end

# private

# def bookmark_params
#   params.require(:bookmark).permit(:comment, :movie_id)
# end
