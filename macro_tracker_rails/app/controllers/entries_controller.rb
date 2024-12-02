class EntriesController < ApplicationController
  include Authentication

  before_action :set_entry, only: %i[show edit update destroy]

  # GET /entries or /entries.json
  def index
    @entries = EntryQuery.for_date(Date.current)
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.prototype
    @entry.food_entries.build
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html do
          redirect_to @entry, notice: "Entry was successfully created."
        end
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @entry.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html do
          redirect_to @entry, notice: "Entry was successfully updated."
        end
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @entry.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy!

    respond_to do |format|
      format.html do
        redirect_to entries_path,
                    status: :see_other,
                    notice: "Entry was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.includes(food_entries: :food).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def entry_params
    params.require(:entry).permit(
      :mealtime,
      :eaten_at,
      food_entries_attributes: %i[food_id servings]
    )
  end
end