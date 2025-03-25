class DeleteOldUpvotesTopics < ActiveRecord::Migration[5.2]
  def change
    change_table :topics do |t|
      t.remove 'up_votes'
    end
  end
end
