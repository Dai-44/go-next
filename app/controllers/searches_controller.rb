class SearchesController < ApplicationController
  def index
  end

  def new
    @user_selection = UserSelectionForm.new
  end

  def create
    @user_selection = UserSelectionForm.new(user_selection_params)
    if @user_selection.valid?
      request_params = @user_selection.to_request_params
      # 処理成功後は、仮でルートパスへ飛ばしておく。
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
