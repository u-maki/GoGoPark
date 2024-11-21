class Park < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_one :facility, dependent: :destroy
  has_many_attached :photos
  validates :name, :latitude, :longitude, :place_id, presence: true
  validates :place_id, uniqueness: true

  require 'net/http'
  require 'uri'
  require 'json'

  # Google Place API から公園情報を取得し、作成または更新する
  def self.fetch_from_google_places(place_id)
    api_key = ENV['GOOGLE_MAPS_API_KEY']
    url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&key=#{api_key}"
    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      
      # ログにレスポンスデータを出力して詳細を確認
      Rails.logger.debug "Google Places API Response: #{data.inspect}"

      result = data['result']

      # レスポンスがnilの場合
      if result.nil?
        Rails.logger.error("Google Places API returned no result for place_id: #{place_id}")
        return nil
      end

      # 必要なデータが存在するか確認
      latitude = result['geometry']&.dig('location', 'lat')
      longitude = result['geometry']&.dig('location', 'lng')

      if latitude.nil? || longitude.nil?
        Rails.logger.error("Latitude or Longitude missing for place_id: #{place_id}")
        return nil
      end

      # 公園情報を作成または更新
      park = Park.find_or_initialize_by(place_id: place_id)
      park.update(
        name: result['name'],
        address: result['formatted_address'],
        latitude: latitude,
        longitude: longitude,
        phone_number: result['formatted_phone_number'],
        website: result['website'],
        rating: result['rating'],
        user_ratings_total: result['user_ratings_total']
      )
      park
    else
      Rails.logger.error("Failed to fetch data from Google Places API for place_id: #{place_id}")
      return nil
    end
  end
end
