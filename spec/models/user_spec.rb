require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "全て入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "a1234"
        @user.password_confirmation = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）を入力してください")
      end
      it "passwordが6文字以上でも英字だけであれば登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含めて入力してください")
      end
      it "passwordが6文字以上でも数字だけであれば登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含めて入力してください")
      end
      it "姓が空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it "名が空だと登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "姓のカナが空だと登録できない" do
        @user.first_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください")
      end
      it "nicknameが空だと登録できない" do
        @user.last_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it "生年月日が空だと登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end