class ParksController < ApplicationController
  def show
    if params[:place_id].present?
      # ローカルデータベースから公園情報を取得
      @park = Park.find_by(google_place_id: params[:place_id])
      
      if @park
        # 公園に関連するコメントを取得
        @comments = @park.comments
      else
        # データベースに該当する公園が見つからない場合、Google Places API から情報を取得
        fetch_google_park_data(params[:place_id])
      end
    else
      flash[:alert] = "公園が見つかりません。"
      redirect_to root_path
    end
  end
  
  private
  
  # Google Places API から公園情報を取得
  def fetch_google_park_data(place_id)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json", {
      query: {
        place_id: place_id,
        key: ENV['GOOGLE_MAPS_API_KEY'],
        fields: "name,formatted_address,photos",
        language: "ja"
      }
    })
  
    if response.success? && response.parsed_response["status"] == "OK"
      @google_park_data = response.parsed_response["result"]
      @comments = Comment.where(google_place_id: place_id)
    else
      flash[:alert] = "公園情報を取得できませんでした。"
      redirect_to root_path
    end
  end
end  