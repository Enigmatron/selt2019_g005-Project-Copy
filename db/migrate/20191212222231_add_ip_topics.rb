class AddIpTopics < ActiveRecord::Migration[5.2]
  def change
    change_table :topics do |t|
      t.string 'ip_address'
    end
  end
end
