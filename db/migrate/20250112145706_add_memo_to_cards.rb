class AddMemoToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :memo, :text
  end
end
