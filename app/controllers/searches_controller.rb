class SearchesController < ApplicationController
  def index
  end

  def new
    @user_selection = UserSelectionForm.new
  end

  def create
    @user_selection = UserSelectionForm.new(user_selection_params)
    if @user_selection.valid?
      session[:request_params] = @user_selection.to_request_params
      flash[:success] = '成功'
      redirect_to result_searches_path
    else
      flash.now[:danger] = '失敗'
      render :new
    end
  end

  def result
    request_params = session[:request_params]
    @response = SearchPlacesService.search_places(request_params)
  end

  private

  def user_selection_params
    params.require(:user_selection_form).permit(:feeling, :drive_range, :latitude, :longitude, type: [])
  end
end
