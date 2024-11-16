class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :comments
         has_many :favorites
         has_many :favorite_parks, through: :favorites, source: :park

         PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  

  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英字と数字を混合させてください' }
  validates :nickname, presence: true
end
