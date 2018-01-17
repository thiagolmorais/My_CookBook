class Favorite < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :recipe, uniqueness: {scope: :user}
end
