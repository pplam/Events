class AddTimestampsToTeamUsers < ActiveRecord::Migration[5.1]
  def change
    add_timestamps(:team_users, null: true)
  end
end
