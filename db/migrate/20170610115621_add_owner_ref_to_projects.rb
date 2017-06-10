class AddOwnerRefToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :owner_id, :integer
    add_foreign_key :projects, :users, column: :owner_id
  end
end
