require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) } # 必要なユーザー
  let(:park) { create(:park) } # 必要なパーク

  describe 'バリデーション' do
    context 'contentが空でない場合' do
      it 'validであること' do
        comment = build(:comment, content: "Nice park!", user: user, park: park)
        expect(comment).to be_valid
      end
    end

    context 'contentが空の場合' do
      it 'invalidであること' do
        comment = build(:comment, content: nil, user: user, park: park)
        expect(comment).not_to be_valid
        expect(comment.errors[:content]).to include("can't be blank")
      end
    end

    context 'google_place_idとpark_idが両方空の場合' do
      it 'エラーになること' do
        comment = build(:comment, content: "Nice park!", user: user, google_place_id: nil, park: nil)
        expect(comment).not_to be_valid
        expect(comment.errors[:base]).to include("公園情報（Google Place ID または Park ID）が必要です。")
      end
    end

    context 'google_place_idまたはpark_idが存在する場合' do
      it 'google_place_idがある場合はvalidであること' do
        comment = build(:comment, content: "Nice park!", user: user, google_place_id: "ChIJd-g71Bn7GGAReEdCZQdW5ls", park: nil)
        expect(comment).to be_valid
      end

      it 'park_idがある場合はvalidであること' do
        comment = build(:comment, content: "Nice park!", user: user, google_place_id: nil, park: park)
        expect(comment).to be_valid
      end
    end

    context 'photosが5枚を超える場合' do
      it '無効であること' do
        comment = build(:comment, content: "Nice park!", user: user, park: park)
        comment.photos.attach(Array.new(6) { fixture_file_upload(Rails.root.join('public/images/test_image.png'), filename: 'test_image.png') })

        expect(comment).not_to be_valid
        expect(comment.errors[:photos]).to include("は最大5枚までアップロード可能です。")
      end
    end

    context 'photosが5枚以内の場合' do
      it 'validであること' do
        comment = build(:comment, user: user, park: park, content: "Nice park!")
        5.times do
          comment.photos.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')), filename: 'test_image.png', content_type: 'image/png')
        end
        comment.save # 保存を呼び出す
        expect(comment).to be_valid
      end
    end
    

    context 'photosが0枚の場合' do
      it 'validであること' do
        comment = build(:comment, user: user, park: park, content: "Nice park!")
        expect(comment).to be_valid
      end
    end
  end
end