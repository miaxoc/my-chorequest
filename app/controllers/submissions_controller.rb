class SubmissionsController < ApplicationController

  #---------#
  # click on the "complete"
  # user goes to the update form
  # upload the picture
  # submit

  # def index
  # end

  def edit
  end

  def update
    @submission = Submission.find(params[:id])
    @user = @submission.user (params[:user_id])
    @user_tasks = Task.where(user_id: @user)
    # get the submission from the params
    # update the status to "complete"
  end

  def destroy
  end

  private
  # fix the strong params
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
