class CreatePasses < ActiveRecord::Migration[7.1]
  def change
    create_table :passes do |t|
      t.string :
      t.string :string

      t.timestamps
    end
  end
end
