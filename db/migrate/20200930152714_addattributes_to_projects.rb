class AddattributesToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :documents_count, :integer, default: 0
  end
end
