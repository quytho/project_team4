class AuthorsController < ApplicationController
  def index
    @authors = Author.paginate(page: params[:page], per_page: 5)
  end

  def show
    @author = Author.find_by_id(params[:id])
  end
end
