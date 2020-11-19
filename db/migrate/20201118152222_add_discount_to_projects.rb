class AddDiscountToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :discount, :float, default: 0
  end
end
