class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :content
      t.references :targetable, polymorphic: true
      t.references :resultable, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
