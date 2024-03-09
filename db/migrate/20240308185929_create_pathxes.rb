class CreatePathxes < ActiveRecord::Migration[7.1]
  def change
    create_table :pathxes do |t|
      t.integer :idx
      t.string :path
      t.string :last_item

      t.timestamps
    end
  end
end
