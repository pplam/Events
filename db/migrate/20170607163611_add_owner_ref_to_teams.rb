class AddOwnerRefToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :owner_id, :integer
    add_foreign_key :teams, :users, column: :owner_id
  end
end
