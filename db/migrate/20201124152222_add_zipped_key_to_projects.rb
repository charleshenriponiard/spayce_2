class AddZippedKeyToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :zipped_key, :string
  end
end
