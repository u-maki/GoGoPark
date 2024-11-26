FactoryBot.define do
  factory :comment do
    content { "This is a test comment" }
    toilet { false }
    diaper_changing_station { false }
    vending_machine { false }
    shop { false }
    parking { false }
    slide { false }
    swing { false }

    google_place_id { "ChIJN1t_tDeuEmsRUsoyG83frY4" }
    park { nil }
    association :user
  end
end


