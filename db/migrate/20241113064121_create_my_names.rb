class CreateMyNames < ActiveRecord::Migration[7.1]
  def change
    create_table :my_names do |t|
      t.string :
      t.string :string

      t.timestamps
    end
  end
end
