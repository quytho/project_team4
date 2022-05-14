module Admin
  class CategoriesController < AdminController
    before_action :find_category, except: %i[index new create]

    def index
      @category = Category.search(params).paginate(page: params[:page], per_page: 3)
    end

    def show; end

    def new
      @category = Category.new
    end

    def create
      @category = Category.create(category_params)
      if @category.save
        flash[:success] = " Category create Successfully"
        redirect_to admin_categories_path
      else
        flash[:warning] = " Category create failed"
        render :new
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
        flash[:success] = " Category update Successfully"
        redirect_to admin_categories_path
      else
        flash[:warning] = " Category update Failed"
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.find_by(id: params[:id])
      return if @category.present?

      flash[:warning] = "That category could not be found"
      redirect_to admin_categories_path
    end
  end
end
