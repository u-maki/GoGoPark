class AddGooglePlaceIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :google_place_id, :string
  end
end
