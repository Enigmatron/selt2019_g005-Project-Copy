class ChangeUpvotesToIntegers < ActiveRecord::Migration[5.2]
  def change
    change_table :topics do |t|
      t.remove 'up_votes'
      t.integer 'up_votes'
    end
  end
end
