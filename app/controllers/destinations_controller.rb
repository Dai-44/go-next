class DestinationsController < ApplicationController
  include Searchable

  def show
    @bookmark_destination = current_user.bookmark_destinations.find(params[:id])
  end

  def bookmarks
    @q = current_user.bookmark_destinations.ransack(params[:q])
    @bookmark_destinations = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    # 検索時の選択肢となるデータを用意
    load_search_options
  end
end
