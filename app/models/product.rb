class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :order
  has_one :address
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :prefecture

  enum condition:{
    '---':           1,
    unused:          2,
    nearly_unused:   3,
    not_injured:     4,
    bit_injured:     5,
    injured:         6,
    bad:             7,
  },  _prefix: true

  enum postage:{
    '---':            1,
    freight_collect:  2,
    prepayment:       3,
  },  _prefix: true

  enum shipment:{
    '---':    1,
    "1_to_2": 2,
    "2_to_3": 3,
    "4_to_7": 4,
  },  _prefix: true

  NUM_REGEX = /\A\d{3,8}\z/

  with_options presence: true do
    validates_presence_of :image, message: "を選択してください"
    validates :title, length: { maximum: 40, message: "は40文字までです" }
    validates :text, length: { maximum: 1000, message: "は1000文字までです" }
    validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000 , message: 'は300〜9,999,999円の間で設定してください' }
  end

  validates :price, format: { with: NUM_REGEX, message: "は半角数字で入力してください" }


  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :prefecture_id
  end

  with_options exclusion: { in: ['---'], message: 'を選択してください' } do
    validates :condition
    validates :postage
    validates :shipment
  end

end