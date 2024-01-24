module DriveRecordsHelper
  # 引数に渡されたドライブ履歴レコード生成日時のデータを「月/日」のフォーマットに変換する処理
  def format_date(drive_record)
    original_datetime = drive_record.created_at

    return original_datetime.strftime("%-m/%-d")
  end

  # 引数に渡されたドライブ履歴レコード生成日時のデータを「月/日」のフォーマットに変換する処理
  def format_date_with_year(drive_record)
    original_datetime = drive_record.created_at

    return original_datetime.strftime("%Y年%-m月%-d日")
  end
end