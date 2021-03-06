#    3accounts - Accounts software for real people 
#    Copyright (C) 2008, Neil Wilson, Aldur Systems
#
#    This file is part of 3accounts
#
#    3accounts is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#

class CreateJournals < ActiveRecord::Migration
  def self.up
    create_table :journals do |t|
      t.string :org_type, :folio, :name
      t.integer :org_id
      t.datetime :posted_at
      t.references :ledger

      t.timestamps
    end

    add_index :journals, :id, :unique => true
    add_index :journals, :ledger_id
  end

  def self.down
    drop_table :journals
  end
end
