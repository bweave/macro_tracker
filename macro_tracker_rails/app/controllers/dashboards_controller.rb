class DashboardsController < ApplicationController
  include Authentication

  def show
    goals = Goal.all.map { |g| [ g.name, g.amount ] }.to_h
    entries =
      Entry
        .includes(food_entries: :food)
        .where(eaten_at: Date.today.all_day)
        .flat_map do |entry|
          entry
            .food_entries
            .map do |fe|
              food = fe.food
              servings = fe.servings
              food.attributes.with_indifferent_access => {
                protein:, carbs:, fat:, calories:, fiber:
              }
              [
                servings * calories,
                servings * carbs,
                servings * fat,
                servings * fiber,
                servings * protein
              ]
            end
            .transpose
            .map(&:sum)
        end
    @today =
      goals.transform_values.with_index { |goal, i| [ entries[i] || 0, goal ] }
  end
end
