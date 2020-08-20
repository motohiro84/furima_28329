class ProductOrder

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone, :product_id, :user_id

  def save
    binding.pry
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone: phone, product_id: product_id)
    Order.create(user_id: user_id, product_id: product_id)
  end

end