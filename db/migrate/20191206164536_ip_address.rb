class IpAddress < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string 'ip_address'
    end
  end
end
