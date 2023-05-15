class ProductsController < ApplicationController
  layout :set_layoyt

  before_action :get_product, except: [:create, :new, :index]

  before_action :only_admin_can_deal_with_products, except: [:index, :show]

  def index
    @products = check_for_admin ? current_user.products : Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to root_path, notice: "you have successfully created a product"
    else
      flash.now[:alert] = "product is not created! Try doing again.."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to root_path, notice: "you have successfully updated the product"
    else
      flash.now[:alert] = "product is not updated! Try doing again.."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "you have successfully deleted the product"
    else
      flash[:alert] = "product's not deleted"
    end
    redirect_to root_path
  end

  private

    def get_product
      @product = Product.find(params[:id])
    end

    def check_for_admin
      current_user.role == "Admin" ? true : false
    end

    def only_admin_can_deal_with_products
      unless check_for_admin
        redirect_to new_user_session_path, alert: "only admins can manage products"
      end
    end

    def set_layoyt
      check_for_admin ? "admin" : "merchant"
    end

    def product_params
      params.require(:product).permit(:name, :cost, :brand, :availability)
    end
end
