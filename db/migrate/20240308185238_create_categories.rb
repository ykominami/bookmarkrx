class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.integer :child_id
      t.integer :generation

      t.timestamps
    end
  end
end
