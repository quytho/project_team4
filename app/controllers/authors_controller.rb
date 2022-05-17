class AuthorsController < ApplicationController
  def index
    @authors = Author.paginate(page: params[:page], per_page: 5)
  end

  def show
    @author = Author.find_by_id(params[:id])
    return if @author.present?

    flash[:warning] = "That author could not be found"
    redirect_to admin_authors_path
  end
end
