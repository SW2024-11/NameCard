class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :my_company
      t.string :my_name
      t.string :pass

      t.timestamps
    end
  end
end
