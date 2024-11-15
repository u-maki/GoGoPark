# README
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

