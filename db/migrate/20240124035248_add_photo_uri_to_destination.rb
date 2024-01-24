class AddPhotoUriToDestination < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :photo_uri, :string
  end
end
