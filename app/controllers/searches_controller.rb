class SearchesController < ApplicationController
  def index
  end

  def new
    @user_selection = SetRequestParamsForm.new
  end

  def create

  end
end
