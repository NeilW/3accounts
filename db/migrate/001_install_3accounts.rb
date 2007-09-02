class Install3accounts < ActiveRecord::Migration
  def self.up
    create_table "accounts", :force => true do |t|
  	t.column :name, :string
   	t.column :created_at,     :datetime
   	t.column :updated_at,     :datetime
    end

    create_table "categories", :force => true do |t|
  	t.column :name, :string
   	t.column :created_at,     :datetime
   	t.column :updated_at,     :datetime
    end

    create_table "entries", :force => true do |t|
    	t.column :account_id,     :integer
    	t.column :category_id ,    :integer
    	t.column :comment,        :string
    	t.column :value,          :decimal, :precision => 8, :scale => 2
   	t.column :created_at,     :datetime
   	t.column :updated_at,     :datetime
    end
  end

  def self.down
    drop_table :categories
    drop_table :entries
    drop_table :accounts
  end
end
