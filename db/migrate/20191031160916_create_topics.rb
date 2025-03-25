class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string 'header'
      t.string 'subject'
      t.float 'up_votes'
      t.timestamps
    end
  end
end
