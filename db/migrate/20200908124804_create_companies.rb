class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_number
      t.string :name
      t.string :business_type
      t.string :address_line1
      t.string :address_line2
      t.string :postal_code
      t.string :city
      t.string :country
      t.string :state
      t.string :phone_number
      t.string :structure
      t.string :verification_status

      t.timestamps
    end
  end
end
