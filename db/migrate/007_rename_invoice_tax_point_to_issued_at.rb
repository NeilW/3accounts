class RenameInvoiceTaxPointToIssuedAt < ActiveRecord::Migration
  def self.up
    rename_column(:invoices, :tax_point, :issued_at)
  end

  def self.down
    rename_column(:invoices, :issued_at, :tax_point)
  end
end
