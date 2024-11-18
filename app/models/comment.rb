class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :park
  validates :content, presence: true  # コメントの内容を必須にする
end
