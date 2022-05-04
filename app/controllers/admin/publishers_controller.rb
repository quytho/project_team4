class Admin::PublishersController < AdminController
  before_action :get_publishers, except: [:index, :new, :create]

  def index
    @publishers = Publisher.search(params)
      .order_name
      .paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.xls { send_data @publishers.to_xls(col_sep: "\t") } 
      end
    end 

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(user_params)
    if @publisher.save
      flash[:success] = "Publisher successfully"
      redirect_to admin_publishers_path
    else
      flash[:warning] = "Publisher create failed"
      render :new
    end
  end

  def show
  end

  def update
    if @publisher.update(user_params)
      flash[:success] = "Publisher updated"
      redirect_to admin_publishers_path
    else
      flash[:warning] = "Publisher update failed"
      render :show
    end
  end

  def destroy
    if @publisher.books.exists?
      flash[:warning] = "Delete failed"
    else
      @publisher&.destroy
      flash[:success] = "Delete successfully"
    end
    redirect_to admin_publishers_path
  end

  private
    def user_params
      params.require(:publisher).permit(:name)
    end
    
    def get_publishers
      @publisher = Publisher.find_by_id(params[:id])
      return if @publisher.present?
      flash[:warning] = "That publisher could not be found"
      redirect_to admin_publishers_path  
    end

end
