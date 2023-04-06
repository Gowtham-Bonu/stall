class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    product = Product.find(params[:product_id])
    if @order.save
      product.orders << @order
      redirect_to root_path, notice: "you have successfully placed an order"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :quantity, :status, :user_id)
  end
end
