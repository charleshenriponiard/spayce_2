class ChangeAmountToAmountCentsInProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :amount, :amount_cents
  end
end
