require 'rails_helper'

RSpec.describe LiveEvent, type: :model do
  describe "バリデーション" do
    # ユーザーを用意
    let(:user) do
      User.create!(
        name: "テストユーザー",
        email: "test123@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    # ライブ情報を用意
    let(:live_event) do
      LiveEvent.new(
        user: user,
        title: "LIVE TOUR TEST",
        event_date: Date.today,
        venue_name: "東京ドーム"
      )
    end

    it "必須項目が入力済であれば予定を登録" do
      expect(live_event).to be_valid
    end

    it "タイトルがない場合は無効" do
      live_event.title = nil
      expect(live_event).to be_invalid
    end

    it "開催日がない場合は無効" do
      live_event.event_date = nil
      expect(live_event).to be_invalid
    end

    it "会場名がない場合は無効" do
      live_event.venue_name = nil
      expect(live_event).to be_invalid
    end
  end
end
