class AddRefrenceToTopicsFromUser < ActiveRecord::Migration[5.2]
  def change
    change_table :topics do |t|
      t.references 'user'
    end
    change_table :users do |t|
      t.remove 'password'
    end
  end
end
