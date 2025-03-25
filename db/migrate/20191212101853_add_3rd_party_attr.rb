class Add3rdPartyAttr < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string 'Email'
      t.string 'profile'
    end
  end
end
