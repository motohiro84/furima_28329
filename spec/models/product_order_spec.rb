require 'rails_helper'

RSpec.describe ProductOrder, type: :model do
  before do
    @product_order = FactoryBot.build(:product_order) 
  end

  describe '商品購入機能' do

    context '購入がうまくいくとき' do

      it "全て入力されていれば購入できる" do
        expect(@product_order).to be_valid
      end
      it '建物名が無くても購入できる' do
        @product_order.building_name = nil
        expect(@product_order).to be_valid
      end

    end

    context '購入がうまくいかないとき' do

      it 'クレジットカード情報を正確に入力してないと購入できない' do
        @product_order.token = ""
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it '郵便番号を入力してないと購入できない' do
        @product_order.postal_code = ""
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号を半角数字で入力してないと購入できない' do
        @product_order.postal_code = "１２３−４５６７"
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("郵便番号は-(ハイフン)を含めた半角数字で入力してください")
      end
      it '郵便番号をハイフンを含めて入力してないと購入できない' do
        @product_order.postal_code = "1234567"
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("郵便番号は-(ハイフン)を含めた半角数字で入力してください")
      end
      it '都道府県を選択してないと購入できない' do
        @product_order.prefecture_id = "1"
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村を入力してないと購入できない' do
        @product_order.city = ""
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地を入力してないと購入できない' do
        @product_order.house_number = ""
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号を入力してないと購入できない' do
        @product_order.phone = ""
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号は半角数字で入力してないと購入できない' do
        @product_order.phone = "０９０１２３４５６７８"
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("電話番号は11桁以内の半角数字のみで入力してください")
      end
      it '電話番号は11桁以内で入力してないと購入できない' do
        @product_order.phone = "090123456789"
        @product_order.valid?
        expect(@product_order.errors.full_messages).to include("電話番号は11桁以内の半角数字のみで入力してください")
      end
 
    end

  end
end
