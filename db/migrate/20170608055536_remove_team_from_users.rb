class RemoveTeamFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :users, column: :team_id
    remove_column :users, :team_id, :integer
  end
end
