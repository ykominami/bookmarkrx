class CreateYs < ActiveRecord::Migration[7.1]
  def change
    create_table :ys do |t|
      t.string :name

      t.timestamps
    end
  end
end
