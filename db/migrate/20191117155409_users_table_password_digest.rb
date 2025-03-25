class UsersTablePasswordDigest < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string 'password_digest'
    end
  end
end
