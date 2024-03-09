class CreateChoiceproposals < ActiveRecord::Migration[7.1]
  def change
    create_table :choiceproposals do |t|
      t.string :content
      t.integer :status

      t.timestamps
    end
  end
end
