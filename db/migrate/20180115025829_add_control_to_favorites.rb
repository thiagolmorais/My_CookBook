class AddControlToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :control, :string
  end
end
