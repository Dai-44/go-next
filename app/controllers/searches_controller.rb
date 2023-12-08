class SearchesController < ApplicationController
  def index
  end

  def new
    @user_selection = UserSelectionForm.new
  end

  def create
    @user_selection = UserSelectionForm.new(user_selection_params)
    if @user_selection.valid?
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def user_selection_params
      params.require(:user_selection_form).permit(:feeling, :drive_time, type: [])
    end
end
