# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 11) do

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "corporation_taxes", :force => true do |t|
    t.integer  "fiscal_year_starting"
    t.integer  "main_rate",            :limit => 3
    t.integer  "small_companies_rate", :limit => 3
    t.integer  "mscr_lower_limit",     :limit => 8
    t.integer  "mscr_upper_limit",     :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.date     "issued_at"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journals", :force => true do |t|
    t.string   "org_type"
    t.string   "folio"
    t.string   "name"
    t.integer  "org_id"
    t.datetime "posted_at"
    t.integer  "ledger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ledgers", :force => true do |t|
    t.string   "loaded_from"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.decimal  "rate",        :precision => 12, :scale => 3
    t.decimal  "quantity",    :precision => 12, :scale => 3
    t.decimal  "vat",         :precision => 12, :scale => 3
    t.string   "description"
    t.string   "tag"
    t.integer  "invoice_id"
    t.integer  "vat_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.string   "memo"
    t.string   "account"
    t.decimal  "amount",     :precision => 12, :scale => 2
    t.integer  "journal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vat_numbers", :force => true do |t|
    t.string   "identifier",   :limit => 12
    t.string   "country_code", :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vat_types", :force => true do |t|
    t.string   "name"
    t.decimal  "rate",       :precision => 12, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
