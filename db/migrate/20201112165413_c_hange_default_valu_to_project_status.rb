class CHangeDefaultValuToProjectStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:projects, :status, nil)
  end
end
