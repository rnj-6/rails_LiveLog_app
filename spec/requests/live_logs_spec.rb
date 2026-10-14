require 'rails_helper'

RSpec.describe "LiveLogs", type: :request do

  # ユーザーを用意
  let(:user) do
    User.create!(
      name: "テストユーザー",
      email: "request_test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  # イベント情報を用意
  let(:live_event) do
    user.live_events.create!(
      title: "LIVE TOUR TEST",
      event_date: Date.today,
      venue_name: "日本武道館"
    )
  end

  let(:live_log) do
    {
      people: "友人",
      content: "楽しいライブだった！"
    }
  end

  before do
    sign_in user
  end

  describe "POST /live_events/:live_event_id/live_log" do
    it "ライブログを作成する" do
      expect {
        post live_event_live_log_path(live_event), params: { live_log: live_log }
        }.to change(LiveLog, :count).by(1)
    end
  end

  describe "PATCH /live_events/:live_event_id/live_log" do
    it "ライブログを編集する" do
      live_event.create_live_log!(live_log)
      patch live_event_live_log_path(live_event), params: {
        live_log: { content: "編集後の感想" }
      }
      expect(live_event.live_log.reload.content).to eq("編集後の感想")
    end
  end

  describe "DELETE /live_events/:live_event_id/live_log" do
    it "ライブログを削除する" do
      live_event.create_live_log!(live_log)
      expect {
        delete live_event_live_log_path(live_event)
      }.to change(LiveLog, :count).by(-1)
    end
  end
end
