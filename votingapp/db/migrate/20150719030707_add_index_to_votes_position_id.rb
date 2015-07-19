class AddIndexToVotesPositionId < ActiveRecord::Migration
  def change
  	add_index :votes, :position_id
  end
end
