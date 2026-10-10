class LiveEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @live_events = current_user.live_events
  end

  def new
    @live_event = current_user.live_events.new
  end

  def create
    @live_event = current_user.live_events.new(live_event_params)
    if @live_event.save
      flash[:notice] = "イベントを登録しました"
      redirect_to live_events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @live_event = current_user.live_events.find(params[:id])
  end

  def update
    @live_event = current_user.live_events.find(params[:id])
    if @live_event.update(live_event_params)
      flash[:notice] = "イベントを編集しました"
      redirect_to live_events_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @live_event = current_user.live_events.find(params[:id])
    @live_event.destroy
    flash[:notice] = "イベントを削除しました"
    redirect_to live_events_path
  end

  private
  def live_event_params
    params.require(:live_event).permit(
      :title,
      :artist_name,
      :event_date,
      :venue_name,
      :address,
      :done
    )
  end
end
