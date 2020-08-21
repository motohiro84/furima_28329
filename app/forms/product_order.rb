class ProductOrder

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone, :product_id, :user_id

  def save
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone: phone, product_id: product_id)
    Order.create(user_id: user_id, product_id: product_id)
  end

  POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/
  PHONE_REGEX = /\A\d{,11}\z/

  validate :card_information

  validates :postal_code, presence: true, format: {with: POSTAL_CODE_REGEX, message: "は-(ハイフン)を含めた半角数字で入力してください"}

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  with_options presence: true do
    validates :city
    validates :house_number
    validates :phone,format: {with: PHONE_REGEX, message: "は11桁以内の半角数字のみで入力してください"}
  end

  def card_information
    if number = "" || exp_month = "" || exp_year = "" || cvc = ""
      errors.add(:token, "を正確に入力してください")
    end
  end

end