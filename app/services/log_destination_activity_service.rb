class LogDestinationActivityService
  def initialize(user_id, destination_info, record_type:)
    @user = User.find(user_id)
    @destination_info = destination_info
    @record_type = record_type
  end

  def call
    type = Type.find_by(name: @destination_info[:type])
    destination = Destination.find_or_create_by(name: @destination_info[:name], address: @destination_info[:address], latitude: @destination_info[:latitude], longitude: @destination_info[:longitude], google_places_api_type: type)
    create_drive_record(destination)
  end

  private

  def create_drive_record(destination)
    @user.drive_records.create(destination: destination)
  end
end
