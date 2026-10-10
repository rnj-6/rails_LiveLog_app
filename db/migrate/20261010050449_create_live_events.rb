class CreateLiveEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :live_events do |t|
      t.string :title
      t.string :artist_name
      t.date :event_date
      t.string :venue_name
      t.boolean :done
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
