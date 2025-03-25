class DeleteLocationUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove 'address'
      t.remove 'longitude'
      t.remove 'latitude'
      t.remove 'ip_address'
    end
    change_table :topics do |t|
      t.remove 'address'
    end
  end
end
