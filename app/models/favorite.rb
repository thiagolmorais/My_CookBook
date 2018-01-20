class Favorite < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :user, uniqueness: {scope: :recipe}

end
