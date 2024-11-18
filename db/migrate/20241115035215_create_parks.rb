class CreateParks < ActiveRecord::Migration[7.0]
  def change
      create_table :parks do |t|
        t.string :name, null: false            # 公園名
        t.string :address                     # 公園の住所
        t.text :description                   # 公園の説明
        t.float :latitude, null: false        # 緯度 (Google Place API で取得)
        t.float :longitude, null: false       # 経度 (Google Place API で取得)
        t.string :place_id, unique: true      # Google Place API の place_id
        t.string :phone_number                # 公園の電話番号 (API で取得可能)
        t.string :website                     # 公園のウェブサイト (API で取得可能)
        t.float :rating                       # 公園の評価 (API で取得可能)
        t.integer :user_ratings_total         # 評価数 (API で取得可能)
  
        t.timestamps
      end
  end
end
