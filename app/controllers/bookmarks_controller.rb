class BookmarksController < ApplicationController
  def create
    # ブックマークする場所の特定と、その場所に関するユーザーのブックマークレコードを生成するLogDestinationActivityServiceのcallメソッドを実行
    service = LogDestinationActivityService.new(
      current_user.id,
      destination_params,
      record_type: 'bookmark'
    )
    service.call

    # ブックマーク処理実行後の遷移先であるcreate.turbo_stream.erbで用いるインスタンス変数の設定
    @destination = service.destination
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, flash: { success: "ブックマークしました" } }
    end
  end

  def destroy
    @destination = current_user.bookmark_destinations.find_by(id: params[:id]) # 受けたリクエストのパラメータを元に、削除対象となるブックマークに紐づくDestinationレコードを特定。自らに関連するレコードのみが削除の候補となるよう、current_userを起点として検索を実行。
    current_user.unbookmark(@destination)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, flash: { success: "ブックマークを解除しました" } }
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :address, :top_level_area, :second_level_area, :latitude, :longitude, :type, :website_uri, :place_id)
  end
end
