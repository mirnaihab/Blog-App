class AddDeviseTokenAuthColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      ## Required
      t.string :provider, null: false, default: "email" unless column_exists?(:users, :provider)
      t.string :uid, null: false, default: "" unless column_exists?(:users, :uid)

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)
      t.boolean  :allow_password_change, default: false unless column_exists?(:users, :allow_password_change)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      ## Confirmable
      t.string   :confirmation_token unless column_exists?(:users, :confirmation_token)
      t.datetime :confirmed_at unless column_exists?(:users, :confirmed_at)
      t.datetime :confirmation_sent_at unless column_exists?(:users, :confirmation_sent_at)
      t.string   :unconfirmed_email unless column_exists?(:users, :unconfirmed_email) # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false unless column_exists?(:users, :failed_attempts) # Only if lock strategy is :failed_attempts
      t.string   :unlock_token unless column_exists?(:users, :unlock_token) # Only if unlock strategy is :email or :both
      t.datetime :locked_at unless column_exists?(:users, :locked_at)

      ## User Info
      t.string :name unless column_exists?(:users, :name)
      t.string :image unless column_exists?(:users, :image)
      t.string :email unless column_exists?(:users, :email)

      ## Tokens
      t.json :tokens unless column_exists?(:users, :tokens)

      t.index [ :uid, :provider ], unique: true unless index_exists?(:users, [ :uid, :provider ])
      t.index [ :email ], unique: true unless index_exists?(:users, :email)
    end
  end
end
