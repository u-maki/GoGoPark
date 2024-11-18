class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false  # コメント内容
      t.references :user, null: false, foreign_key: true  # ユーザーとの関連
      t.references :park, null: false, foreign_key: true  # 公園との関連
      t.timestamps
    end
  end
end
