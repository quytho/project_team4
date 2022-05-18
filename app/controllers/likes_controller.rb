class LikesController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token
  def create
    @like = Like.new(like_params)
    if @like.save
      flash[:success] = "like successfully"
    else
      flash[:warning] = "like create failed"
    end
  end

  def destroy
    @like = Like.find_by_id(params[:id])
    @like.destroy
  end

  private

  def like_params
    params.permit(:id, :book_id, :user_id)
  end
end
