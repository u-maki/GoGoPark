class AddGooglePlaceIdToParks < ActiveRecord::Migration[7.0]
  def change
    add_column :parks, :google_place_id, :string
  end
end
