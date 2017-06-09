class AddAcceptedToTeamUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :team_users, :accepted, :boolean
  end
end
