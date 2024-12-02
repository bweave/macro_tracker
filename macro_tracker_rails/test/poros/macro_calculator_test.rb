require "test_helper"

class MacroCalculatorTest < ActiveSupport::TestCase
  test "the truth" do
    subject = MacroCalculator.new(
      gender: "male",
      height: 70,
      height_unit: "in",
      weight: 175,
      weight_unit: "lb",
      age: 45,
      activity_level: "moderately_active",
      goal: "weight_maintenance"
    )
    expected = {
      calories: 2_695,
      protein: 114,
      carbs: 358,
      fat: 90
    }
    actual = subject.daily_macros

    assert_equal expected, actual
  end
end
