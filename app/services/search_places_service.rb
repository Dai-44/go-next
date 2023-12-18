class SearchPlacesService
  API_ENDPOINT = 'https://places.googleapis.com/v1/places:searchNearby'
  API_KEY = Rails.application.credentials.api_key&.fetch(:google)

  def self.search_places(params)
    uri = URI(API_ENDPOINT)
    # メソッド内部の可読性向上のため、field_maskの生成はprivateメソッドとして定義する
    field_mask = build_field_mask
    headers = { 'Content-Type' => 'application/json', 'X-Goog-Api-Key' => API_KEY, 'X-Goog-FieldMask' => field_mask }
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

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri, headers)
    request.body = body.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.build_field_mask
    [
      'places.types', 'places.addressComponents', 'places.location',
      'places.rating', 'places.googleMapsUri', 'places.websiteUri',
      'places.businessStatus', 'places.userRatingCount',
      'places.displayName', 'places.currentOpeningHours',
      'places.primaryType', 'places.restroom'
    ].join(',')
  end

  private_class_method :build_field_mask # クラスメソッドであるbuild_field_maskをプライベート化。privateキーワードはインスタンスのコンテキストに基づいて動作するもので、クラスメソッドには適用されないため左記の記載としている。
end
