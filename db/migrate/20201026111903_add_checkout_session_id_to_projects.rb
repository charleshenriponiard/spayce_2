class AddCheckoutSessionIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :checkout_session_id, :string
  end
end
