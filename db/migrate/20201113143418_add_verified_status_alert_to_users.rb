class AddVerifiedStatusAlertToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :verified_status_alert, :boolean, default: false
  end
end
