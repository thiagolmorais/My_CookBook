class AddDadosPessoaisToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :city, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
  end
end
