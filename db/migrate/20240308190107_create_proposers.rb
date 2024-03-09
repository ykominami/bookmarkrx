class CreateProposers < ActiveRecord::Migration[7.1]
  def change
    create_table :proposers do |t|
      t.string :name
      t.string :session

      t.timestamps
      t.bigint "prevote_id", null: false
      t.bigint "proposer_id", null: false
      t.index ["prevote_id"], name: "index_proposers_on_prevote_id"
      t.index ["proposer_id"], name: "index_proposers_on_proposer_id"
    end
  end
end
