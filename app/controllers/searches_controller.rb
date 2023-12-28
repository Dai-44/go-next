class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[index new create result]
  def index; end

  def new
    @user_selection = UserSelectionForm.new
  end

  def create
    @user_selection = UserSelectionForm.new(user_selection_params)
    if @user_selection.valid?
      session[:request_params] = @user_selection.to_request_params # to_request_paramsはUserSelectionForm内で定義している
      redirect_to result_searches_path
    else
      render :new
    end
  end

  def result
    @response = SearchPlacesService.search_places(session[:request_params])
  end

  private

  def user_selection_params
    params.require(:user_selection_form).permit(:feeling, :drive_range, :latitude, :longitude, type: [])
  end
end
