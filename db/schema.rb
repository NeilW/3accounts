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

ActiveRecord::Schema.define(:version => 1) do

  create_table "corporation_taxes", :force => true do |t|
    t.integer  "fiscal_year_starting"
    t.integer  "main_rate",            :limit => 3, :precision => 3, :scale => 0
    t.integer  "small_companies_rate", :limit => 3, :precision => 3, :scale => 0
    t.integer  "mscr_lower_limit",     :limit => 8, :precision => 8, :scale => 0
    t.integer  "mscr_upper_limit",     :limit => 8, :precision => 8, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
