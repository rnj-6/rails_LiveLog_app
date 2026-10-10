class LiveEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @live_events = current_user.live_events
  end

  def new
  end
end
