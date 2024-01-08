class DriveRecordsController < ApplicationController
  def create
    service = LogDestinationActivityService.new(
      current_user.id,
      destination_params,
      record_type: 'drive_record'
    )
    service.call
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :address, :latitude, :longitude, :type)
  end
end
