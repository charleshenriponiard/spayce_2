class AddPaymentIntentIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :payment_intent_id, :string
  end
end
