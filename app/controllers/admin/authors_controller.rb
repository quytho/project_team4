module Admin
  class AuthorsController < AdminController
    before_action :get_authors, except: %i[index new create]

    def index
      @authors = Author.search(params)
                       .order_name
                       .paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.xls { send_data @authors.to_xls(col_sep: "\t") }
      end
    end

    def new
      @author = Author.new
    end

    def create
      @author = Author.new(user_params)
      if @author.save
        flash[:success] = 'Author successfully'
        redirect_to admin_authors_path
      else
        render :new
      end
    end

    def show; end

    def update
      if @author.update(user_params)
        flash[:success] = 'Author updated'
        redirect_to admin_authors_path
      else
        render :new
      end
    end

    def destroy
      if Book.where(author_id: params[:id]).empty?
        @author.destroy
        flash[:success] = 'Delete successfully'
      else
        flash[:danger] = 'Delete failed'
      end
      redirect_to admin_authors_path
    end

    private

    def user_params
      params.require(:author).permit(:name)
    end

    def get_authors
      @author = Author.find_by_id(params[:id])
      return if @author.present?

      flash[:warning] = 'That author could not be found'
      redirect_to admin_authors_path
    end
  end
end
