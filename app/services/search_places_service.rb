class SearchPlacesService
  API_ENDPOINT = 'https://places.googleapis.com/v1/places:searchNearby' # Google Places APIへのアクセスポイント
  API_KEY = Rails.application.credentials.api_key&.fetch(:google)

  # Google Places APIへのリクエストを実行してレスポンスを受け取るメソッド。引数のparamsには、UserSelectionFormインスタンスにto_request_paramsメソッドを実行することで得られるハッシュが渡される。
  def self.search_places(params)
    # APIのエンドポイントからURIオブジェクトを作成。ホストやポートなど、URLの要素に簡単にアクセスして操作できるようになる。
    uri = URI(API_ENDPOINT)
    # メソッド内部の可読性向上のため、field_maskの生成はprivateメソッドとして下部で定義している
    field_mask = build_field_mask
    # APIへのリクエストのヘッダー内容を設定
    headers = { 'Content-Type' => 'application/json', 'X-Goog-Api-Key' => API_KEY, 'X-Goog-FieldMask' => field_mask }
    # APIへのリクエストのボディ内容を設定
    body = {
      includedTypes: params['included_types'],
      excludedPrimaryTypes: params['excluded_primary_types'],
      locationRestriction: {
        circle: {
          center: { latitude: params['latitude'], longitude: params['longitude'] },
          radius: params['radius']
        }
      },
      languageCode: 'ja'
    }

    http = Net::HTTP.new(uri.host, uri.port) # Google Places APIへのリクエストを実行するHTTPクライアントを作成
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri, headers) # Google Places APIへのリクエスト内容を作成
    request.body = body.to_json

    response = http.request(request) # httpのrequestメソッドを実行し、得られたレスポンス(JSON)をresponseに格納
    JSON.parse(response.body) # JSON形式で与えられたレスポンスのボディをRubyで扱えるデータ構造(この処理の場合はハッシュが返ってきた)に変換
  end

  def self.build_field_mask
    [
      'places.types', 'places.formattedAddress', 'places.location',
      'places.rating', 'places.googleMapsUri', 'places.websiteUri',
      'places.businessStatus', 'places.userRatingCount',
      'places.displayName', 'places.currentOpeningHours',
      'places.primaryType', 'places.restroom'
    ].join(',')
  end

  # クラスメソッドであるbuild_field_maskをプライベート化。privateキーワードはインスタンスのコンテキストに基づいて動作するもので、クラスメソッドには適用されないためprivate_class_methodを用いている。
  private_class_method :build_field_mask
end
