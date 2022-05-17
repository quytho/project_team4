module Admin
  class BorrowRequetsController < AdminController
    skip_before_action :verify_authenticity_token
    before_action :find_borrow_request, except: %i[index new create]

    def index
      @borrow_requets = BorrowRequet.includes(:user, :book)
                                    .paginate(page: params[:page], per_page: 10)
    end

    def update
      if params[:status].nil?
        if @borrow_requet.update(borrow_params)
          flash[:success] = " Accept Successfully"
        else
          flash[:warning] = "Borrow update failed"
        end
      elsif @borrow_requet.update(status: params[:status])
        flash[:success] = " Accept Successfully"
      else
        flash[:warning] = "Borrow update failed"
      end
      redirect_to request.referrer
    end

    def show; end

    private

    def borrow_params
      params.require(:borrow_requet).permit(:status, :return_date, :status_borrow, :id, :update_status)
    end

    def find_borrow_request
      @borrow_requet = BorrowRequet.find_by_id(params[:id])
      return if @borrow_requet.present?

      flash[:warning] = "That request could not be found"
      redirect_to admin_borrow_requets_path
    end
  end
end
