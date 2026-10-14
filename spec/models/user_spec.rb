require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do

    # ユーザーを用意
    let(:user) do
      User.new(
        name: "テストユーザー",
        email: "test123@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    it "必須項目が入力済であれば有効" do
      expect(user).to be_valid
    end

    it "名前がない場合は無効" do
      user.name = nil
      expect(user).to be_invalid
    end

    it "メールアドレスがない場合は無効" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "メールアドレスが重複している場合は無効" do
      user.save!
      another_user = User.new(
        name: "別のユーザー",
        email: user.email,
        password: "password123",
        password_confirmation: "password123" 
      )
      expect(another_user).to be_invalid
    end

    it "パスワードがない場合は無効" do
      user.password = nil
      expect(user).to be_invalid
    end

    it "パスワード確認がない場合は無効" do
      user.password_confirmation = nil
      expect(user).to be_invalid
    end

    it "パスワードと確認用パスワードが一致しない場合は無効" do
      user.password_confirmation = "password987"
      expect(user).to be_invalid
    end
  end
end
