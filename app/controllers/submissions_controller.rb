class SubmissionsController < ApplicationController
  # Submission is created at the same time as the Task is created
  # Submission's defaul status is "incomplete"
  # When the task is marked as complete, it changes the submission's status to
  # complete.

  def index
  end

  def show
  end

  def new
    @submission = Submission.new
  end

  def create

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # def submission_params
  #   params.require(:submission).permit(:status, :photo)
  # end
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
