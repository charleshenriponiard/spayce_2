class AddColumnToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :spayce_commission, :float, default: 0.00
    add_column :projects, :tax, :float, default: 0.00
    add_column :projects, :total, :float, default: 0.00
  end
end
