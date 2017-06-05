class AddForeignKeyToTodos < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :todos, :users, column: :creator_id
    add_foreign_key :todos, :users, column: :executor_id
  end
end
