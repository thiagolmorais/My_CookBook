class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  validates :title, :difficulty, :cook_time, :ingredients,:method, presence: true


  def favorite?(user)
    if user
      return user.favorite_recipes.include? self
    end
    false
  end

end
