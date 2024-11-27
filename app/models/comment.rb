class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :park, optional: true
  has_many_attached :photos

  validates :content, presence: true
  validates :toilet, :diaper_changing_station, :vending_machine, :shop,
            :parking, :slide, :swing, inclusion: { in: [true, false] }, allow_nil: true
  validate :google_place_id_or_park_id
  validate :photos_count_within_limit

  private

  def google_place_id_or_park_id
    if google_place_id.blank? && park_id.blank?
      errors.add(:base, "公園情報（Google Place ID または Park ID）が必要です。")
    end
  end

  def photos_count_within_limit
    if photos.attached? && photos.count > 5
      errors.add(:photos, "は最大5枚までアップロード可能です。")
    end
  end
  
end
