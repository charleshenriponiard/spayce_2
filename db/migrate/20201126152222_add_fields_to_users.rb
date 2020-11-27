class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :siret, :string
    add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :entity_name, :string
  end
end
