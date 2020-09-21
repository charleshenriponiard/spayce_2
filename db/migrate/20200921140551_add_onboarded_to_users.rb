class AddOnboardedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :onboarded, :boolean, default: false, null: false
  end
end
