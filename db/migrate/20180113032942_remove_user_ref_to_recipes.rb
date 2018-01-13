class RemoveUserRefToRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :recipes, :username, foreign_key: true
  end
end
