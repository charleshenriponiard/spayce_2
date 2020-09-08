class AddStripeFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :access_code, :string
    add_column :users, :publishable_key, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :country, :string
  end
end
