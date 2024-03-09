class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.string :href
      t.string :desc
      t.datetime :add_date
      t.datetime :last_modified
      t.timestamps
      t.bigint "pathx_id"

      t.index ["pathx_id"], name: "index_bookmarks_on_pathx_id"
    end
  end
end
