class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string 'handle'
      t.string 'password'
      t.string 'session_token'
      t.timestamps
    end
  end
end
