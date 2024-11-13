class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :company
      t.string :name
      t.string :position
      t.string :license
      t.string :mail
      t.string :tell
      t.string :company_adress
      t.binary :image

      t.timestamps
    end
  end
end
