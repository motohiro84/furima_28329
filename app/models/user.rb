class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :orders


  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  NAME_READING_REGEX = /\A[ァ-ヶー－]+\z/
  HALF_REGEX = /\A[a-zA-Z0-9]+\z/
  MIXTURE_REGEX = /(?=.*?[a-z])(?=.*?[\d])/i

  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: NAME_REGEX, message: "は全角で入力してください" }
    validates :last_name, format: { with: NAME_REGEX, message: "は全角で入力してください" }
    validates :first_name_reading, format: { with: NAME_READING_REGEX, message: "は全角カタカナで入力して下さい" }
    validates :last_name_reading, format: { with: NAME_READING_REGEX, message: "は全角カタカナで入力して下さい" }
    validates :birthday
    validates :password, format: { with: HALF_REGEX, message: 'は半角の英数字で入力して下さい' }
    validates :password, format: { with: MIXTURE_REGEX, message: 'は英字と数字の両方を含めて入力してください' }
    validates :password_confirmation
    validates :email, uniqueness: true
  end

end
