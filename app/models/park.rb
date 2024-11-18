class Park < ApplicationRecord
  has_many :comments, dependent: :destroy  # 公園に対するコメント
  has_one :facility, dependent: :destroy
  has_many_attached :photos # 複数の写真を添付可能
  validates :name, :latitude, :longitude, :place_id, presence: true
  validates :place_id, uniqueness: true

  # Google Place API からデータを同期するメソッド
  def self.fetch_from_google_places(api_response)
    park = Park.find_or_initialize_by(place_id: api_response[:place_id])
    park.update(
      name: api_response[:name],
      address: api_response[:formatted_address],
      latitude: api_response[:geometry][:location][:lat],
      longitude: api_response[:geometry][:location][:lng],
      phone_number: api_response[:formatted_phone_number],
      website: api_response[:website],
      rating: api_response[:rating],
      user_ratings_total: api_response[:user_ratings_total]
    )
    park
  end
end
