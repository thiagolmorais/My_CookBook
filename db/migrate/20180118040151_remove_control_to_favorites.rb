class RemoveControlToFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorites, :control, :string
  end
end
