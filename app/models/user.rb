class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :yahoojp]

  has_many :products, dependent: :destroy
  has_many :orders
  has_many :sns_credentials
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  NAME_READING_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  HALF_REGEX = /\A[a-zA-Z0-9]+\z/.freeze
  MIXTURE_REGEX = /(?=.*?[a-z])(?=.*?[\d])/i.freeze

  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: NAME_REGEX, message: 'は全角で入力してください' }
    validates :last_name, format: { with: NAME_REGEX, message: 'は全角で入力してください' }
    validates :first_name_reading, format: { with: NAME_READING_REGEX, message: 'は全角カタカナで入力して下さい' }
    validates :last_name_reading, format: { with: NAME_READING_REGEX, message: 'は全角カタカナで入力して下さい' }
    validates :birthday
    validates :password, format: { with: HALF_REGEX, message: 'は半角の英数字で入力して下さい' }
    validates :password, format: { with: MIXTURE_REGEX, message: 'は英字と数字の両方を含めて入力してください' }
    validates :password_confirmation
    validates :email, uniqueness: true
  end
end
