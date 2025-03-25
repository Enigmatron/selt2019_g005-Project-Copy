class Add3rdPartyAttr2 < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string 'provider'
      t.string 'uid'
    end
  end
end
