module SearchesHelper
  # 引数に渡された場所の住所示す文字列を生成する処理
  def format_address(place)
    original_address = place['formattedAddress']

    return original_address.split.last
  end


  # 現在の曜日に基づいて、引数に渡された場所の営業時間に関する文字列を生成する処理
  def format_opening_hours(place)
    return "営業時間: 対象情報がありません" if place['currentOpeningHours'].nil? || place['currentOpeningHours']['weekdayDescriptions'].nil? # 対象となる情報がAPIのレスポンスに含まれない場合の処理

    current_day_index = Time.zone.now.wday
    weekday_descriptions = place['currentOpeningHours']['weekdayDescriptions']
    
    opening_hours_for_today = weekday_descriptions[current_day_index - 1] # 曜日に対応する営業時間の文字列を取得。Time.zone.now.wdayの戻り値が示す曜日と、Google Places APIからレスポンスとして受け取る営業時間の配列が示す曜日のインデックスに差があるため、調整している。

    # 曜日に対応する営業時間の文字列から、曜日を指す文字列のみを取得
    day_of_week = opening_hours_for_today.split(':').first

    # 表示したい文字列を組み立てる
    "営業時間(#{day_of_week}) : #{opening_hours_for_today.split(':')[1].strip}"
  end
end