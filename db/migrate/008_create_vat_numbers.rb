class CreateVatNumbers < ActiveRecord::Migration
  def self.up
    create_table :vat_numbers do |t|
      t.string :identifier, :limit => 12
      t.string :country_code, :limit => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :vat_numbers
  end
end
