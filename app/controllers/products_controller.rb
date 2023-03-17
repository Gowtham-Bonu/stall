class ProductsController < ApplicationController
  layout :fix_layoyt
  before_action :get_product, only: [:edit, :update, :destroy, :show]

  def get_product
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def show
  end

  private

    def fix_layoyt
      if current_user.role == "Admin"
        "admin"
      else
        "merchant"
      end
    end

    def product_params
      params.require(:product).permit(:name, :cost, :brand, :availability)
    end
end
