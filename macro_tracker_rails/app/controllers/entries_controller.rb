class EntriesController < ApplicationController
  include Authentication

  before_action :set_entry, only: %i[show edit update destroy]

  def index
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @entries = EntryQuery.for_date(@date.all_day)
  end

  def show
  end

  def new
    @entry = Entry.prototype
    @entry.food_entries.build
  end

  def edit
  end

  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      refresh_or_redirect_to entries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @entry.update(entry_params)
      refresh_or_redirect_to entries_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy!

    refresh_or_redirect_to entries_path, status: :see_other
  end

  private

  def set_entry
    @entry = Entry.includes(food_entries: :food).find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(
      :user_id,
      :mealtime,
      :eaten_at,
      food_entries_attributes: %i[id food_id servings]
    )
  end
end
