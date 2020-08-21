class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_order, only: [:index, :create, :pay_product]


  def index
    @order = ProductOrder.new(order_params)
    if current_user.id == @product.user_id || Order.find_by(product_id: @product.id)
      redirect_to root_path
    end
  end

  def create
    @order = ProductOrder.new(order_params)
    if @order.valid?
      pay_product
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone, :product_id, :token).merge(user_id: current_user.id)
  end

  def pay_product
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: params[:token],
      currency:'jpy'
    )
  end

  def set_product_order
    @product = Product.find(params[:product_id])
  end

end
