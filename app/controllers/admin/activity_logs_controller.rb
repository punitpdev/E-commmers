# app/controllers/activity_logs_controller.rb
class Admin::ActivityLogsController < ApplicationController
  def index
    @activity_logs = ActivityLog.order(created_at: :desc)
  end

  def show
    @activity_log = ActivityLog.find(params[:id])
  end
end
