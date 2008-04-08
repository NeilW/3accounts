class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.decimal :rate, :quantity, :vat, :precision => 12, :scale => 3 
      t.string :description, :tag
      t.references :invoice, :vat_type

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
