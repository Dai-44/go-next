class SearchesController < ApplicationController
  def index
  end

  def new
    @user_selection = UserSelectionForm.new
  end

  def create

  end
end
