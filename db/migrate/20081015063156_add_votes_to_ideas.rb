class AddVotesToIdeas < ActiveRecord::Migration
  def self.up
    add_column :ideas, :votes, :integer
  end

  def self.down
    remove_column :ideas, :votes
  end
end
