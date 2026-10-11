class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest, only: [:edit, :update]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if password_change_requested?
      if @user.update_with_password(user_params)
        bypass_sign_in(@user)
        flash[:notice] = "ユーザー情報を更新しました"
        redirect_to users_path
      else
        render :edit, status: :unprocessable_entity
      end

    elsif @user.update(profile_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def check_guest
    if current_user.guest?
      flash[:alert] = "ゲストユーザーはユーザー情報を変更できません"
      redirect_to users_path
    end
  end

  def password_change_requested?
    params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  def user_params
    params.require(:user).permit(
      :name,
      :profile_image,
      :email,
      :password,
      :current_password,
      :password_confirmation
    )
  end

  def profile_params
    params.require(:user).permit(
      :name,
      :profile_image,
      :email
    )
  end
end
