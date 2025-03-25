class Add3rdPartyRename < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.rename 'Email', 'email'
    end
  end
end
