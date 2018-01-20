class Recipe < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }#, default_url: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:filename'
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user, foreign_key: 'user_id'
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
