class AddDeletedAtToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :deleted_at, :datetime
    add_index :todos, :deleted_at
  end
end
