class Facility < ApplicationRecord
  belongs_to :park
  has_many :facility_photos, dependent: :destroy
  has_many_attached :photos # 複数の写真を添付可能

  validates :toilet, :diaper_changing_station, :vending_machine, :shop, 
            :parking, :slide, :swing, inclusion: { in: [true, false] }
end
