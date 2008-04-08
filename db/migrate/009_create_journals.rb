class CreateJournals < ActiveRecord::Migration
  def self.up
    create_table :journals do |t|
      t.string :org_type, :folio, :name
      t.integer :org_id
      t.datetime :posted_at
      t.references :ledger

      t.timestamps
    end
  end

  def self.down
    drop_table :journals
  end
end
