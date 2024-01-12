class DriveRecordsController < ApplicationController
  include Searchable

  def index
    @q = current_user.drive_records.ransack(params[:q])
    @drive_records = @q.result(distinct: true).includes(:destination).order(created_at: :desc).page(params[:page])
    # 検索時の選択肢となるデータを用意
    load_search_options
    load_additional_search_options
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
    params.require(:destination).permit(:name, :address, :top_level_area, :second_level_area, :latitude, :longitude, :type)
  end

  # ドライブ履歴の検索時に特有の選択肢となるデータを取得してインスタンス変数に格納する処理
  def load_additional_search_options
    @visited_months = DriveRecord.get_unique_visited_months
  end
end
