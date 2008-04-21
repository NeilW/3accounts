class CreateFixedAssets < ActiveRecord::Migration
  def self.up
    create_table :fixed_assets do |t|
      t.decimal :bought_for, :sold_for, :scale => 2, :precision => 12
      t.date :bought_on, :sold_on
      t.references :journal
      t.timestamps
    end
  end

  def self.down
    drop_table :fixed_assets
  end
end
