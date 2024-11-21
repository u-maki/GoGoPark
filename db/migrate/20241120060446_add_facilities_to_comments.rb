class AddFacilitiesToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :toilet, :boolean, default: false
    add_column :comments, :diaper_changing_station, :boolean, default: false
    add_column :comments, :vending_machine, :boolean, default: false
    add_column :comments, :shop, :boolean, default: false
    add_column :comments, :parking, :boolean, default: false
    add_column :comments, :slide, :boolean, default: false
    add_column :comments, :swing, :boolean, default: false
  end
end
