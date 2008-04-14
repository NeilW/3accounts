class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.date :start_at
      t.date :end_at
      t.references :journal

      t.timestamps
    end
  end

  def self.down
    drop_table :periods
  end
end
