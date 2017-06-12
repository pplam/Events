class AddColumnsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :target_field, :string
    add_column :events, :result_field, :string
  end
end
