class CreateLedgers < ActiveRecord::Migration
  def self.up
    create_table :ledgers do |t|
      t.string :loaded_from

      t.timestamps
    end
  end

  def self.down
    drop_table :ledgers
  end
end
