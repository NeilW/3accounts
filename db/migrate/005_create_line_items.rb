class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.decimal :rate, :quantity, :vat_rate, :precision => 10, :scale => 2 
      t.string :description, :tag, :type
      t.references :invoice

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
