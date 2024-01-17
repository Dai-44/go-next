class AddWebsiteUriToDestination < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :website_uri, :string
  end
end
