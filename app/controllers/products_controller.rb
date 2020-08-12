class ProductsController < ApplicationController

  before_action :move_to_index, except: [:index]

  def index
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
  end

  private

  def product_params
    params.require(:product).permit()
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
