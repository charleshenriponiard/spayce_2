class AddVerificationStatusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :verification_status, :integer, default: 0
  end
end
