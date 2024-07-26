class RenameAuthorIdToUserIdInPosts < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :author_id, :user_id
  end
end
