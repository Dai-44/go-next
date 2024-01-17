class DriveRecordsController < ApplicationController
  def index
    @q = current_user.drive_records.ransack(params[:q])
    @drive_records = @q.result(distinct: true).includes(:destination).order(created_at: :desc).page(params[:page])
    load_search_options # 検索時の選択肢となるデータを用意
  end

  def show
    @drive_record = current_user.drive_records.find(params[:id])
    @drive_record_destination = @drive_record.destination
  end

  def create
    # 目的地となる場所の特定と、その場所へのユーザーのドライブ履歴を生成するLogDestinationActivityServiceのcallメソッドを実行
    service = LogDestinationActivityService.new(
      current_user.id,
      destination_params,
      record_type: 'drive_record'
    )
    if service.call
      redirect_to root_path, flash: { success: "ドライブ履歴を保存しました" } # 処理後は仮でルートパスに遷移しているが、実際は経路案内を表示する画面に遷移させる。画面のUI/UXを整える過程で修正する。
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :address, :top_level_area, :second_level_area, :latitude, :longitude, :website_uri, :type)
  end

  # 検索時の選択肢となるデータを取得してインスタンス変数に格納する処理
  def load_search_options
    @areas = current_user.visited_destinations.get_unique_areas
    @types = current_user.visited_destinations.map(&:google_places_api_type).uniq.map(&:display_name).sort
    @visited_months = current_user.drive_records.get_unique_visited_months
  end
end
