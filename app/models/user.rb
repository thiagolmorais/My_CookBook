class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes, inverse_of: 'username'
  has_many :favorites, dependent: :destroy 
  has_many :favorite_recipes, through: :favorites, source: :recipe
end
