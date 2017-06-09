class CreateTeamUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_users do |t|
      t.integer :team_id
      t.integer :user_id
    end
    add_index :team_users, [:team_id, :user_id], unique: true, name: :team_user
  end
end
