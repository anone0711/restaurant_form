class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else  
      @categories = Category.all
      render :index
    end
  end

  before_action :set_category, only: [:update, :destroy]
  def update
    if @category.update(category_params)
      flash[:notice] = "category was successfully updated"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    if @category.destroy
      flash[:alert] = "Category was successfully deleted"
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
