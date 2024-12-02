# README

## usersテーブル

| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer | null: false, primary key |
| nickname           | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |

### Association
- has_many :comments
- has_many :favorites
- has_many :favorite_parks, through: :favorites, source: :park

## Parksテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer | null: false, primary key |
| park_name          | string  | null: false |
| postal_code        | string  |
| address            | text    |
| latitude           | integer | null: false |
| longitude          | integer | null: false |

### Association
- has_many :comments
- has_many :favorites
- has_many :favorited_by_users, through: :favorites, source: :user  

## Commentsテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer | null: false, primary key |
| content            | text    | null: false |
| user_id            | integer - references Users |
| park_id            | integer - references Parks |
| created_at         | datetime | null: false |
| updated_at         | datetime | null: false |

### Association
- belongs_to :user
- belongs_to :park
- has_many :comment_facilities
- has_many :facilities, through: :comment_facilities

## Facilitiesテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer | null: false, primary key |
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
| id                 |  integer | null: false, primary key |
| comment_id         | integer | null: false, foreign_key: true |
| facility_id        | integer | null: false, foreign_key: true |
| created_at         | datetime | null: false
| updated_at         | datetime | null: false

### Association
- belongs_to :comment
- belongs_to :facility


## Favoritesテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| id                 | integer | null: false, primary key |
| user_id            | integer |null: false, foreign_key: true |
| park_id            | integer |null: false, foreign_key: true |
| created_at         | datetime | null: false |
| updated_at         | datetime | null: false |

### Association
- belongs_to :user
- belongs_to :park

