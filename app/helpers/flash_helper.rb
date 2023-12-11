module FlashHelper
  def flash_class(type)
    case type.to_sym
    # 'flash-success'や'flash-danger'などはフラッシュメッセージ用のカスタムスタイルであり、app/stylesheets/flash_messages.cssで定義している
    when :success
      'flash-success'
    when :danger
      'flash-danger'
    when :info
      'flash-info'
    when :warning
      'flash-warning'
    else
      'flash-info'
    end
  end
end
