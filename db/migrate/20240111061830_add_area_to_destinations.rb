class AddAreaToDestinations < ActiveRecord::Migration[7.1]
  def change
    add_column :destinations, :area, :string, null: false
  end
end
