class CreateHierxes < ActiveRecord::Migration[7.1]
  def change
    create_table :hierxes do |t|
      t.integer :parent_id
      t.integer :child_id
      t.integer :generation

      t.timestamps

      t.index ["child_id"], name: "index_hierxes_on_child_id"
      t.index ["generation"], name: "index_hierxes_on_generation"
      t.index ["parent_id"], name: "index_hierxes_on_parent_id"
    end
  end
end
