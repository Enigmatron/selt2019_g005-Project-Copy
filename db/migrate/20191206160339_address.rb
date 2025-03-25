class Address < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.rename 'full_address', 'address'
    end
    change_table :topics do |t|
      t.rename 'full_address', 'address'
    end
  end
end
