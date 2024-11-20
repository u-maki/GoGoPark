class Facility < ApplicationRecord
  belongs_to :park
  has_many :facility_photos, dependent: :destroy
  has_many_attached :photos # 写真を添付可能

  # バリデーション: すべてのブール属性に同じ条件を適用
  FACILITY_ATTRIBUTES = %i[トイレ オムツ台 自販機 売店 駐車場 ブランコ 滑り台].freeze
  validates *FACILITY_ATTRIBUTES, inclusion: { in: [true, false] }
end
 