class BooksController < ApplicationController
  before_action :logged_in_user

  def index
      @books = Book.includes(:author, :rates, :follows).search(params)
      .paginate(page: params[:page], per_page: 12)
  end
    
end
