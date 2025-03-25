class AddLocationDataUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string 'full_address'
      t.float 'longitude'
      t.float 'latitude'
    end
  end
end
