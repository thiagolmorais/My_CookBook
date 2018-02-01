class RemoveMethodFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :method, :string
  end
end
