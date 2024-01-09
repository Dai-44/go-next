class DriveRecordsController < ApplicationController
  def index
    @drive_records = current_user.drive_records.includes(:destination).order(created_at: :desc).page(params[:page])
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
    params.require(:destination).permit(:name, :address, :latitude, :longitude, :type)
  end
end
