class FollowsController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token
  def create
    @follow = Follow.save(follow_params)
    if @follow.save
      flash[:success] = "follow successfully"
      redirect_to request.referrer
    else
      flash[:warning] = "follow failed"
      redirect_to request.referrer
    end
  end
  def destroy
    @followid = Follow.find_by_id(params[:id])
    @followid.destroy
  end
  private
    def follow_params
      params.permit(:id, :book_id, :user_id)
    end
end