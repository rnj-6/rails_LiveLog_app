require 'rails_helper'

RSpec.describe "LiveEvents", type: :request do

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
    {
      title: "LIVE TOUR TEST",
      event_date: Date.today,
      venue_name: "日本武道館"
    }
  end

  # ライブログ情報を用意
  let(:live_log) do
    {
      people: "友人",
      content: "楽しいライブだった！"
    }
  end

  before do
    sign_in user
  end

  describe "GET /live_events" do

    it "ログイン後予定リストページにアクセスする" do
      get live_events_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /live_events" do

    context "有効なパラメータの場合" do
      it "イベントの予定を登録する" do
        expect {
          post live_events_path, params: { live_event: live_event }
        }.to change(LiveEvent, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "イベントの予定を登録しない" do
        expect {
          post live_events_path, params: { live_event: live_event.merge(title: "") }
        }.not_to change(LiveEvent, :count)
      end
    end
  end

  describe "PATCH /live_events/:id" do

    it "イベントの予定を編集する" do
      live_event_record = user.live_events.create!(live_event)
      patch live_event_path(live_event_record), params: {
        live_event: { title: "編集後の公演名" }
      }
      expect(live_event_record.reload.title).to eq("編集後の公演名")
    end
  end

  describe "DELETE /live_events/:id" do

    it "イベントの予定を削除する" do
      live_event_record = user.live_events.create!(live_event)
      expect {
        delete live_event_path(live_event_record)
      }.to change(LiveEvent, :count).by(-1)
    end

    it "イベントの予定を削除すると紐づくライブログも削除される" do
      live_event_record = user.live_events.create!(live_event)
      live_event_record.create_live_log!(live_log)
      expect {
        delete live_event_path(live_event_record)
      }.to change(LiveEvent, :count).by(-1)
      .and change(LiveLog, :count).by(-1)
    end
  end
end
