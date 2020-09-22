class RemoveOnboardedFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :onboarded, :boolean
  end
end
