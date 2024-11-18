class CreateFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :facilities do |t|
      t.references :park, null: false, foreign_key: true # 公園情報との関連（公園ごとに1つの設備情報）
      t.boolean :toilet, default: false, null: false
      t.boolean :diaper_changing_station, default: false, null: false
      t.boolean :vending_machine, default: false, null: false
      t.boolean :shop, default: false, null: false
      t.boolean :parking, default: false, null: false
      t.boolean :slide, default: false, null: false
      t.boolean :swing, default: false, null: false

      t.timestamps
    end
  end
end
