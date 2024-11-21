class ParksController < ApplicationController
  def show
    if params[:id] && Park.exists?(id: params[:id])
      # 公園情報を取得
      @park = Park.find_by(google_place_id: params[:place_id]) # 公園をplace_idで取得
      @comments = @park.comments if @park # 公園に関連するコメントを取得
    
    elsif params[:place_id]
      # Google Place APIから公園情報を取得
      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json", {
        query: {
          place_id: params[:place_id],
          key: ENV['GOOGLE_MAPS_API_KEY'],
          fields: "name,formatted_address,photos",
          language: "ja"
        }
      })

      if response.code == 200 && response.parsed_response["status"] == "OK"
        @google_park_data = response.parsed_response["result"]
        @comments = Comment.where(google_place_id: params[:place_id])
      else
        flash[:alert] = "公園情報を取得できませんでした。"
        redirect_to root_path and return
      end
    else
      flash[:alert] = "公園が見つかりません。"
      redirect_to root_path
    end
  end
end

