class GoalsController < ApplicationController
  include Authentication

  before_action :set_goal, only: %i[update]

  def update
    @goal.update(goal_params)
    render turbo_stream:
             turbo_stream.replace(
               @goal,
               partial: "goals/form",
               locals: {
                 goal: @goal
               }
             )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def goal_params
    params.require(:goal).permit(:amount)
  end
end
