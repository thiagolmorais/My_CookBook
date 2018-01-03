class AddPeopleServeToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :people_serve, :string
  end
end
