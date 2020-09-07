class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  
  def create
    @favorite = current_user.favorites.build(product_id: params[:product_id])
    @favorite.save
  end
  
  def destroy
    @favorite = Favorite.find_by(product_id: params[:product_id], user_id: current_user.id)
    @favorite.destroy
  end

  def set_item
    @product = Product.find(params[:product_id])
  end

end
