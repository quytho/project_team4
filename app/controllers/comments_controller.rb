class CommentsController < ApplicationController
  def create
    @books = Book.find_by(id: params[:book_id])
    @comment = @books.comments.create(comment_params)
    redirect_to book_path(@books)
  end

  def destroy
    @books = Book.find_by(id: params[:book_id])
    @comment = @books.comments.find(params[:id])
    @comment.destroy
    redirect_to book_path(@books)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :book_id)
  end
end
