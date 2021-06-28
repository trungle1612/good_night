class CreateTimeSleeps < ActiveRecord::Migration[6.1]
  def change
    create_table :time_sleeps do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.datetime :start_time, null: false
      t.datetime :finish_time, null: false

      t.timestamps
    end

    add_index :time_sleeps, [:user_id, :date], unique: true
  end
end
