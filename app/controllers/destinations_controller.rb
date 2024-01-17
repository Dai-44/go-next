class DestinationsController < ApplicationController
  def show
    @bookmark_destination = current_user.bookmark_destinations.find(params[:id])
  end

  def bookmarks
    @q = current_user.bookmark_destinations.ransack(params[:q])
    @bookmark_destinations = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    load_search_options # 検索時の選択肢となるデータを用意
  end

  private

  # 検索時の選択肢となるデータを取得してインスタンス変数に格納する処理
  def load_search_options
    @areas = current_user.bookmark_destinations.get_unique_areas
    @types = current_user.bookmark_destinations.map(&:google_places_api_type).uniq.map(&:display_name).sort
  end
end
