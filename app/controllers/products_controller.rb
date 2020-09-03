class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.includes(:user).order('created_at DESC')
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    @product.images = []
    array_images(@product.images)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def search
    @products = Product.search(params[:keyword])
    @keyword = params[:keyword]
  end

  private

  def product_params
    params.require(:product).permit(:title, :text, :price, :category_id, :condition, :postage, :prefecture_id, :shipment, images: [] ).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def array_images(images)
    params[:product][:images].each_key{|i|
      images.attach(params[:product][:images][i][:image])
    }
  end

end
