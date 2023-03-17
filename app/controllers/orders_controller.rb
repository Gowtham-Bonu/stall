class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def order_params
    params.require(:order).permit(:name, :quantity, :status, :product_id)
  end
end
