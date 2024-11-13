class CreateMyCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :my_companies do |t|
      t.string :
      t.string :string

      t.timestamps
    end
  end
end
