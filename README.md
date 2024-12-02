# GoGoPark

## ◾サービス概要
公園検索アプリは、近くの公園を簡単に見つけることができるウェブアプリケーションです。Google Place APIを活用して、公園の位置情報や詳細を提供します。また、ユーザーが登録し、コメントを投稿することで、コミュニティとの交流を深める機能もあります。

## ◾アプリケーションを作成した背景
お出掛先で急な空き時間（約30分程）ができた時、子連れだとカフェを利用するのも躊躇してしまうし、ファミレスだと時間が足りないので公園へ連れていきたいが検索に時間がかかって結局子供を待たせるだけになってしまう。という様な問題を解決するために、現在地周辺にある公園が検索をせずとも即座にわかるアプリを作成しました。また、トイレの有無や自販機の有無が分かれば効率的に動けて、少しでも長い時間子供と楽しい時間を過ごせると思い工夫してみました。


## ◾主な機能

### メイン機能
- 公園検索: 現在地を基に、周辺の公園を検索。

### その他機能
- 公園の詳細表示: 公園の名前、住所、写真、評価などを表示。
- ユーザー登録: ユーザーはアカウントを作成してログイン可能。
- コメント機能: 公園についての感想や情報を他のユーザーと共有。

### これから実装したい機能
- マイページ機能： お気に入りの公園登録や、いいね👍の登録。
- 住所検索機能： 特定の住所を検索してその周辺の公園情報の表示。

## ◾使用技術
### バックエンド
- Ruby 3.2.0
- Ruby on Rails 7.0.0
- MySQL
- gem
  - devise
  - google_places
  - gon

- API
  - Google Maps JavaScript API
  - Google Places API
  - Google Geolocation API
    
### インフラ
- render

# データベース設計
## usersテーブル

| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer |
| nickname           | string  |
| email              | string  |
| encrypted_password | string  |

### Association
- has_many :comments
- has_many :favorites
- has_many :favorite_parks, through: :favorites, source: :park

## Parksテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer |
| park_name          | string  |
| postal_code        | string  |
| address            | text    |
| latitude           | integer |
| longitude          | integer |

### Association
- has_many :comments
- has_many :favorites
- has_many :favorited_by_users, through: :favorites, source: :user  

## Commentsテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer |
| content            | text    |
| user_id            | integer - references Users |
| park_id            | integer - references Parks |
| created_at         | datetime |
| updated_at         | datetime |

### Association
- belongs_to :user
- belongs_to :park
- has_many :comment_facilities
- has_many :facilities, through: :comment_facilities

## Facilitiesテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer |
| toilet             | integer |
| diaper             | integer |
| shop               | integer |
| vending            | integer |
| parking            | integer |
| slide              | integer |
| swing              | integer |

### Association
- has_many :comment_facilities
- has_many :comments, through: :comment_facilities

## CommentFacilitiesテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 |  integer |
| comment_id         | integer - references Comments |
| facility_id        | integer - references Facilities |
| created_at         | datetime |
| updated_at         | datetime |

### Association
- belongs_to :comment
- belongs_to :facility


## Favoritesテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer |
| user_id            | integer - references Users |
| park_id            | integer - references Parks |
| created_at         | datetime |
| updated_at         | datetime |

### Association
- belongs_to :user
- belongs_to :park

