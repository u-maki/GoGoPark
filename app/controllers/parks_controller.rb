class ParksController < ApplicationController
  def show
    if params[:id] && Park.exists?(id: params[:id])
      # ローカルDBの公園情報を取得
      @park = Park.find(params[:id])
      @comments = Comment.where(google_place_id: params[:place_id])
    elsif params[:place_id]
      # Google Place APIから公園情報を取得
      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json", {
        query: {
          place_id: params[:place_id],
          key: ENV['GOOGLE_MAPS_API_KEY'],
          fields: "name,formatted_address,photos"
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

