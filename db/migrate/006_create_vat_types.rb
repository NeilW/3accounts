class CreateVatTypes < ActiveRecord::Migration
  def self.up
    create_table :vat_types do |t|
      t.string :name
      t.decimal :rate, :precision => 12, :scale => 3
      t.timestamps
    end

    say_with_time "Adding UK VAT types" do
      VatType.create(:name => "Standard", :rate => 0.175)
      VatType.create(:name => "Lower", :rate => 0.175)
      VatType.create(:name => "Zero", :rate => 0)
      VatType.create(:name => "Exempt", :rate => 0)
      VatType.create(:name => "Out of Scope", :rate => 0)
    end

  end

  def self.down
    drop_table :vat_types
  end
end
