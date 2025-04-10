class CreateActivityLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :activity_logs do |t|
      t.string :record_type
      t.integer :record_id
      t.string :action
      t.text :message

      t.timestamps
    end
  end
end
