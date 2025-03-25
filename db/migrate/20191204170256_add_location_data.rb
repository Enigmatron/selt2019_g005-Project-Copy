class AddLocationData < ActiveRecord::Migration[5.2]
  def change
    change_table :topics do |t|
      t.string 'full_address'
      t.float 'longitude'
      t.float 'latitude'
    end
  end
end
