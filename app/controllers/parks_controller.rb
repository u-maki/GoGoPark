class ParksController < ApplicationController
  # app/controllers/parks_controller.rb
class ParksController < ApplicationController
  def show
    @park = Park.find_by(place_id: params[:id])

    if @park.nil?
      # Google Maps APIから公園情報を取得
      @google_park_data = fetch_park_from_google(params[:id])
    else
      @comments = @park.comments
    end
  end

  private

  # Google Maps APIから詳細情報を取得するメソッド
  def fetch_park_from_google(place_id)
    api_key = ENV['GOOGLE_MAPS_API_KEY']
    url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&key=#{api_key}"

    response = HTTParty.get(url)
    JSON.parse(response.body)['result']
  end
end

end
