class OrdersController < ApplicationController
  before_action :get_order, except: [:new, :create]

  def index
    product = Product.find(params[:product_id])
    @orders = product.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    product = Product.find(params[:product_id])
    if @order.save
      product.orders << @order
      redirect_to root_path, notice: "you have successfully placed an order"
    else
      flash.now[:alert] = [@order.errors.full_messages].join(", ") 
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      redirect_to root_path
    else
      flash.now[:alert] = [@order.errors.full_messages].join(",") 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.destroy
      flash[:notice] = "you have successfully cancelled the order"
    else
      flash[:alert] = [@order.errors.full_messages].join(", ")
    end
    redirect_to root_path
  end

  private
    def get_order
      @order = Order.find_by(id: params[:id])
    end  

    def order_params
      params.require(:order).permit(:name, :quantity)
    end
end
