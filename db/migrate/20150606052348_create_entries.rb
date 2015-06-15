class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body
      t.integer :blog_id

      t.timestamps null: false
    end
  end
end
