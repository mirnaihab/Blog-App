class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :tags, array: true, default: []
      t.text :comments

      t.timestamps
    end
  end
end
