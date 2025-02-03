class DashboardsController < ApplicationController
  include Authentication

  def show
    @stats, @goals = StatsQuery.new(time_range).call
  end

  private

  def time_range
    case params["range"]
    when "today"
      Date.today.all_day
    when "week"
      Date.today.beginning_of_week..Date.today.end_of_week
    when "month"
      Date.today.beginning_of_month..Date.today.end_of_month
    when /\d{4}-\d{2}-\d{2}_\d{4}-\d{2}-\d{2}/
      starting, ending = params["range"].split("_")
      Date.parse(starting)..Date.parse(ending)
    else
      Date.today.all_day
    end
  end
end
