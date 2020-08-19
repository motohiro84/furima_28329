class OrdersController < ApplicationController

  def index
    @product = Product.find(params[:product_id])
  end

  def new
  end

  def create
  end

end
