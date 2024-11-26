FactoryBot.define do
  factory :park do
    name { "Test Park" }
    latitude { 35.6895 }  # 例: 東京の緯度
    longitude { 139.6917 } # 例: 東京の経度
    place_id { SecureRandom.hex(12) }
    google_place_id { SecureRandom.hex(12) }
    address { "123 Test Street, Test City" }

    # その他の属性や関連付け
  end
end
