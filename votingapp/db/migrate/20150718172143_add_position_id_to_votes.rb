class AddPositionIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :position_id, :integer
  end
end
