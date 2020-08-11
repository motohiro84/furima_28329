class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :orders

  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力してください。" }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力してください" }
    validates :first_name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力して下さい" }
    validates :last_name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力して下さい" }
    validates :birthday
    validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'は半角の英数字で入力して下さい' }
    validates :password, format: { with: /(?=.*?[a-z])(?=.*?[\d])/i, message: 'は英字と数字の両方を含めて入力してください' }
    validates :password_confirmation
    validates :email, uniqueness: true
  end

end
