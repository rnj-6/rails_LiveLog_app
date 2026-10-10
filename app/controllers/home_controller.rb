class HomeController < ApplicationController
  def index 
    # ログイン済なら一覧へ遷移
    if user_signed_in?
      redirect_to live_events_path
    end
  end
end

