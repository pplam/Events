class CreateAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :accesses do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
