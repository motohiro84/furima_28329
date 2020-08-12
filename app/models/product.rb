class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :order
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
    prepayment:       2,
    freight_collect:  3,
  },  _prefix: true

  enum shipment:{
    '---':    1,
    "1_to_2": 2,
    "2_to_3": 3,
    "4_to_7": 4,
  },  _prefix: true

end