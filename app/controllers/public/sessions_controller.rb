class Public::SessionsController < ApplicationController

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to root_path
  end
end
