class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :string
      t.string :description
      t.string :text

      t.timestamps
    end
  end
end
