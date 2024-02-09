class SearchesController < ApplicationController
  skip_before_action :require_login, only: %i[new create result retry]

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
    photo_resources = fetch_place_photo_names(@response)
    @photos = SearchPlacesService.fetch_place_photos(photo_resources) # 各場所の画像データを取得する処理。現状ではリクエストの度にAPIへのリクエストが実行されてしまうので、キャッシュを利用した画像の保持などを検討する。
  end

  def retry
    @user_selection = UserSelectionForm.new
  end

  private

  def user_selection_params
    params.require(:user_selection_form).permit(:feeling, :drive_range, :latitude, :longitude, type: [])
  end

  # Google Places APIからのレスポンスとして受け取った各場所の画像の文字列IDを取得する処理。ここで取得した文字列IDを用いて、SearchPlacesServiceにてGoogle Places APIに対する画像データ取得のリクエストを実行する。
  def fetch_place_photo_names(places)
    # 各場所の1件目の画像の文字列IDを格納するための配列。各場所には複数の画像が紐づいているが、それぞれの1件目のみを取得する。
    photo_names = []

    places['places'].each do |place| # 各場所に対するループ処理
      # 各場所の`photos`キーをチェックし、画像が存在する場合は最初の画像を取得
      if place['photos'] && !place['photos'].empty?
        photo_names << place['photos'].first['name']
      else
        photo_names << nil # 画像が存在しない場合はnilや空のデータを追加する
      end
    end

    photo_names
  end
end
