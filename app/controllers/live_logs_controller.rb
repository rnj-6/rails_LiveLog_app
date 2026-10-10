class LiveLogsController < ApplicationController
  before_action :authenticate_user!

  def new
    @live_event = current_user.live_events.find(params[:live_event_id])
    @live_log = @live_event.build_live_log
  end

  def create
    @live_event = current_user.live_events.find(params[:live_event_id])
    @live_log = @live_event.build_live_log(live_log_params)
    
    if @live_log.save
      flash[:notice] = "ライブログを作成しました"
      redirect_to live_events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @live_event = current_user.live_events.find(params[:live_event_id])
    @live_log = @live_event.live_log
  end

  private

  def live_log_params
    params.require(:live_log).permit(
      :people,
      :content
    )
  end
end
