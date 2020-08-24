require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全て入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'パスワードは半角英数字混合でないと登録できない' do
        @user.password = 'ａ１２３４５'
        @user.password_confirmation = 'ａ１２３４５'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角の英数字で入力して下さい')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）を入力してください')
      end
      it 'passwordが6文字以上でも英字だけであれば登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて入力してください')
      end
      it 'passwordが6文字以上でも数字だけであれば登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて入力してください')
      end
      it '姓が空だと登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字を入力してください')
      end
      it '名が空だと登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください')
      end
      it '姓のカナが空だと登録できない' do
        @user.first_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)を入力してください')
      end
      it 'nicknameが空だと登録できない' do
        @user.last_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)を入力してください')
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
      it '姓が全角でないと登録できない' do
        @user.first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は全角で入力してください')
      end
      it '名が全角でないと登録できない' do
        @user.last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角で入力してください')
      end
      it '姓のフリガナが全角でないと登録できない' do
        @user.first_name_reading = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は全角カタカナで入力して下さい')
      end
      it '名のフリガナが全角でないと登録できない' do
        @user.last_name_reading = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前(カナ)は全角カタカナで入力して下さい')
      end
      it 'メールアドレスに@が含まれないと登録できない' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
    end
  end
end
