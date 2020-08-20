class OrdersController < ApplicationController

  def index
    @product = Product.find(params[:product_id])
    if current_user.id == @product.user_id || Order.find_by(product_id: @product.id)
      redirect_to root_path
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @order = ProductOrder.new(order_params)
    @order.valid?
    if @order.save
      redirect_to root_path
    else
      render "index"
    end
  end

  private

  def order_params
    params.permit( :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone, :product_id).merge(user_id: current_user.id)
  end

  def pay_product
    @product = Product.find(params[:product_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: params[:token],
      currency:'jpy'
    )
  end

end
