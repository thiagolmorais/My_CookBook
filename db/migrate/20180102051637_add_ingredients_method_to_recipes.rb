class AddIngredientsMethodToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :ingredients, :string
    add_column :recipes, :method, :string
  end
end
