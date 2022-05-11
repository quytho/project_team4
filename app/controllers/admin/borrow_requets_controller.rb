module Admin
  class BorrowRequetsController < AdminController
    skip_before_action :verify_authenticity_token
    before_action :get_borrow_request, except: %i[index new create]

    def index
      @borrow_requets = BorrowRequet.includes(:user, :book)
                                    .paginate(page: params[:page], per_page: 10)
    end

    def update
      if @borrow_requet.update(status: params[:status])
        flash[:success] = ' Accept Successfully'
      else
        flash[:warning] = 'Publisher update failed'
      end
      redirect_to request.referrer
    end

    def show; end

    private

    def book_params
      params.require(:borrow_requets).permit(:status)
    end

    def get_borrow_request
      @borrow_requet = BorrowRequet.find_by_id(params[:id])
      return if @borrow_requet.present?

      flash[:warning] = 'That request could not be found'
      redirect_to admin_borrow_requets_path
    end
  end
end
