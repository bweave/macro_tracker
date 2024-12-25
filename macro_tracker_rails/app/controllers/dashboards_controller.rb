class DashboardsController < ApplicationController
  include Authentication

  def show
    @stats, @goals = StatsQuery.new.call
  end
end
