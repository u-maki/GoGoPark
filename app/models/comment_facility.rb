class CommentFacility < ApplicationRecord
  belongs_to :comment
  belongs_to :facility
end
