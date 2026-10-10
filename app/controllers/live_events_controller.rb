class LiveEventsController < ApplicationController
  def index
    @live_events = current_user.live_events
  end

  def new
  end
end
