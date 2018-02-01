class RemoveMethodsFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :methods, :text
  end
end
