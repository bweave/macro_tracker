class MacroCalculatorsController < ApplicationController
  def new
    @macro_calculator = MacroCalculator.new
  end

  def create
    @macro_calculator = MacroCalculator.new(macro_calculator_params)

    if @macro_calculator.valid?
      render turbo_stream:
        turbo_stream.replace(
          "macro_results",
          partial: "macro_results",
          locals: {
            macro_calculator: @macro_calculator
          }
        )
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def macro_calculator_params
    params.require(:macro_calculator).permit(
      :gender,
      :height,
      :height_unit,
      :weight,
      :weight_unit,
      :age,
      :activity_level,
      :goal
    )
  end
end
