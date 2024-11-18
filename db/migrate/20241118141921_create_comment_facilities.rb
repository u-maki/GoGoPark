class CreateCommentFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_facilities do |t|
      t.references :comment, null: false, foreign_key: true
      t.references :facility, null: false, foreign_key: true

      t.timestamps
    end
  end
end
