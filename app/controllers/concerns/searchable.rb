module Searchable
  extend ActiveSupport::Concern

  # 検索時の選択肢となるデータを取得してインスタンス変数に格納する処理
  def load_search_options
    @areas = Destination.get_unique_areas
    @types = GooglePlacesApiType.get_display_name
  end
end