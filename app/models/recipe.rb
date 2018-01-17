class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  has_many :favorites
  has_many :users, through: :favorites
  validates :title, :difficulty, :cook_time, :ingredients,:method, presence: true
end
