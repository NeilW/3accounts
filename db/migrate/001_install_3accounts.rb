class Install3accounts < ActiveRecord::Migration
  def self.up
    create_table "accounts", :force => true do |t|
  	t.column "name", :string
    end

    create_table "categories", :force => true do |t|
  	t.column "name", :string
    end

    create_table "entries", :force => true do |t|
    	t.column "account_id",     :integer
    	t.column "category_id",    :integer
    	t.column "effective_date", :date
    	t.column "checked",        :boolean
    	t.column "check_number",   :string
    	t.column "comment",        :string
    	t.column "value",          :float
   	t.column "created_at",     :datetime
    end
  end

  def self.down
    drop_table :categories
    drop_table :entries
    drop_table :accounts
  end
end
