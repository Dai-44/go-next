class BookmarksController < ApplicationController
  def create
    # ブックマークする場所の特定と、その場所へのユーザーのブックマークレコードを生成するLogDestinationActivityServiceのcallメソッドを実行
    service = LogDestinationActivityService.new(
      current_user.id,
      destination_params,
      record_type: 'bookmark'
    )
    if service.call
      redirect_to root_path, flash: { success: "ブックマークしました" } # 処理後は仮でルートパスに遷移しているが、実際は経路案内を表示する画面に遷移させる。画面のUI/UXを整える過程で修正する。
    end
  end

  def destroy
    destination = current_user.bookmarks.find_by(id: params[:id])&.destination
    current_user.unbookmark(destination)
    redirect_to root_path, status: :see_other, flash: { success: "ブックマークを削除しました" } # 処理後は仮でルートパスに遷移しているが、実際は経路案内を表示する画面に遷移させる。画面のUI/UXを整える過程で修正する。
  end
end
