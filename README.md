# README

<h1 align="center">こんにちは 👋、u-maki です</h1>
<h3 align="center">公園検索アプリは、近くの公園を簡単に見つけることができるウェブ アプリケーションです。Google プレイスAPIを活用して、公園の位置情報や詳細を提供します。また、ユーザーが登録し、コメントを投稿することで、コミュニティとの交流を深める機能もあります。</h3>

<h3 align=" left">ご連絡ください:</h3>
<p align="left">
</p>

<h3 align="left">言語とツール:</h3>
<p align="left"> <a href="https://developer.mozilla.org/en-US/docs/Web /JavaScript" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg" alt="javascript" width="40" height="40"/> </a> <a href="https://www.mysql.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/ master/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="40" height="40"/> </a> <a href="https://rubyonrails.org" target= "_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width=" 40" 高さ="40"/> </a> <a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ルビー" 幅="40" 高さ="40"/> </a> </p>

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

