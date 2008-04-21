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

class Ledger < ActiveRecord::Base
  with_options :dependent => :delete_all, :include => [:transactions, :period], :class_name => 'Journal' do |ledger|
    ledger.has_many :journals
    ledger.has_many :transactions, :through => :journals
    ledger.has_many :periodic_journals,
      :conditions => ['org_type not in (?)',
        ['Transfer', 'Bill Pmt -CCard', 'Bill Pmt -Cheque', 'Payment']]
    ledger.has_many :invoices,
      :conditions => ['org_type = ?', 'Invoice']
    ledger.has_many :bills,
      :conditions => ['org_type = ?', 'Bill']
    ledger.has_many :transfers,
      :conditions => ['org_type = ?', 'Transfer']
    ledger.has_many :credit_card_charges,
      :conditions => ['org_type = ?', 'Credit Card Charge']
    ledger.has_many :bill_payments,
      :conditions => ['org_type in (?)',
        ['Bill Pmt -CCard', 'Bill Pmt -Cheque']]
    ledger.has_many :deposits,
      :conditions => ['org_type = ?', 'Deposit']
    ledger.has_many :cheques,
      :conditions => ['org_type = ?', 'Cheque']
    ledger.has_many :general_journals,
      :conditions => ['org_type = ?', 'General Journal']
    ledger.has_many :payments,
      :conditions => ['org_type = ?', 'Payment']
  end

  validates_presence_of(:loaded_from)

  def new_journals=(journal_list)
    journal_list.each do |journal|
      journals.build(journal)
    end
  end

  def self.load_journals(journal_file)
    journal_list = {
      :loaded_from => journal_file.name,
      :new_journals => []
    }
    journal_file.each do |journal|
      journal_list[:new_journals] << journal
    end
    unless journal_list[:new_journals].empty?
      ledger = Ledger.create(journal_list)
      ledger.journals.count
    else
      0
    end
  end

end
