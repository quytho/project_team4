module Admin
  class CategoriesController < AdminController
    before_action :get_category, except: %i[index new create]

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
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to admin_categories_path
      else
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

    def get_category
      @category = Category.find_by(id: params[:id])
      redirect_to admin_categories_path unless @category
    end
  end
end
