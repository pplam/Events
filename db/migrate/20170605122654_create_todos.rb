class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :content
      t.date :deadline
      t.integer :status
      t.references :project, foreign_key: true
      t.integer :creator_id
      t.integer :executor_id

      t.timestamps
    end
  end
end
