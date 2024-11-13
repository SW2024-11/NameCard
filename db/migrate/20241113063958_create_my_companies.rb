class CreateMyCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :my_companies do |t|
      t.string :string

      t.timestamps
    end
  end
end
