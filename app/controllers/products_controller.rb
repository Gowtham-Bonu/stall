class ProductsController < ApplicationController
  layout :fix_layoyt

  before_action :get_product, only: [:edit, :update, :destroy, :show]

  before_action :check_for_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user.role == "Admin"
      @products = current_user.products
    else
      @products = Product.all
    end
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "you have successfully created a product"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to root_path, notice: "you have successfully updated the product"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path, status: :see_other, notice: "you have successfully deleted the employee"
    else
      redirect_to root_path, status: :unprocessable_entity, alert: "The delete action didn't work.."
    end
  end

  private

    def get_product
      @product = Product.find(params[:id])
    end

    def check_for_admin
      if current_user.role != "Admin"
        redirect_to new_user_session_path, notice: "only admins can manage products"
      end
    end

    def fix_layoyt
      current_user.role == "Admin" ? "admin" : "merchant"
    end

    def product_params
      params.require(:product).permit(:name, :cost, :brand, :availability, :user_id)
    end
end
