require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
    @product.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品出品機能の実装' do

    context '商品出品ががうまくいくとき' do
      it 'ログインしていて全て入力されいれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '商品出品ががうまくいかないとき' do
      it 'ログインしていないと出品できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("ユーザー情報を入力してください")
      end
      it '出品画像を選択していないと出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("出品画像を選択してください")
      end
      it '商品名が入力されていないと出品できない' do
        @product.title = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品名が40文字を超えると出品できない' do
        @product.title = Faker::Lorem.paragraph_by_chars(number: 41 )
        @product.valid?
        expect(@product.errors.full_messages).to include("商品名は40文字までです")
      end
      it '商品の説明が入力されていないと出品できない' do
        @product.text = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の説明を入力してください")
      end
      it '商品の説明が1000文字を超えると出品できない' do
        @product.text = Faker::Lorem.paragraph_by_chars(number: 1001 )
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の説明は1000文字までです")
      end
      it 'カテゴリーを選択していないと出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it '発送元の地域を選択していないと出品できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it '商品の状態を選択していないと出品できない' do
        @product.condition = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の状態を選択してください")
      end
      it '配送料の負担を選択していないと出品できない' do
        @product.postage = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it '発送までの日数を選択していないと出品できない' do
        @product.shipment = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it '販売価格が入力されていないと出品できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格を入力してください")
      end
      it '販売価格が300円未満だと出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格は300〜9,999,999円の間で設定してください")
      end
      it '販売価格が10000000円以上だと出品できない' do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格は300〜9,999,999円の間で設定してください")
      end
      it '販売価格が全角だと出品できない' do
        @product.price = "３００"
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格は半角数字で入力してください")
      end
    end
  end

end
