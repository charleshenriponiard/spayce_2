class AddDefaultValueToproject < ActiveRecord::Migration[6.0]
  def change
    change_column_default :projects, :url, from: true, to: nil
  end
end
