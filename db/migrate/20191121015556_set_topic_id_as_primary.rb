class SetTopicIdAsPrimary < ActiveRecord::Migration[5.2]
  def change
    change_table :topics do |t|
      t.rename 'id', 'topic_id'
      # t.primary_key 'topic_id'
    end
  end
end
