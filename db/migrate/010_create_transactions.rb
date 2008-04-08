class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :memo, :account
      t.decimal :amount, :precision => 12, :scale => 2
      t.references :journal

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
