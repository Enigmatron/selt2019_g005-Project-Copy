class AddAdminProperty < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.boolean 'Admin'
    end
  end
end
