class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :amount
      t.string :client_email
      t.string :url
      t.string :client_first_name
      t.string :client_last_name
      t.text :message

      t.timestamps
    end
  end
end
