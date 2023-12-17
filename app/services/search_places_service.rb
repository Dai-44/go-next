class SearchPlacesService
  API_ENDPOINT = 'https://places.googleapis.com/v1/places:searchNearby'
  API_KEY = Rails.application.credentials.api_key&.fetch(:google)

  def self.search_places(params)
    uri = URI(API_ENDPOINT)
    field_mask = ['places.types', 'places.addressComponents', 'places.location', 'places.rating', 'places.googleMapsUri', 'places.websiteUri', 'places.businessStatus', 'places.userRatingCount', 'places.displayName', 'places.currentOpeningHours','places.primaryType', 'places.restroom'].join(',')
    headers = { 'Content-Type' => 'application/json', 'X-Goog-Api-Key' => API_KEY, 'X-Goog-FieldMask' => field_mask }
    body = {
      includedTypes: params[:included_types],
      excludedPrimaryTypes: params[:excluded_primary_types],
      locationRestriction: {
        circle: {
          center: { latitude: params[:latitude], longitude: params[:longitude] },
          radius: params[:radius]
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
end
