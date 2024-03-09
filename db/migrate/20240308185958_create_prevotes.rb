class CreatePrevotes < ActiveRecord::Migration[7.1]
  def change
    create_table :prevotes do |t|

      t.timestamps
      t.bigint "proposer_id", null: false
      t.index ["proposer_id"], name: "index_prevotes_on_proposer_id"
    end
  end
end
