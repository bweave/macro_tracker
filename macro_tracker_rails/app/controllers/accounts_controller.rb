class AccountsController < ApplicationController
  def show
    @user = Current.user
    @goals = Goal.for_current_user
  end

  def destroy
    Current.user.destroy
    redirect_to root_path, notice: "Account deleted successfully."
  end
end
