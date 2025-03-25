class AddUserId < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.rename 'id', 'user_id'
    end
  end
end
