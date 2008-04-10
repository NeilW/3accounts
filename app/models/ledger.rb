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

require 'qb_6_journal_file'
class Ledger < ActiveRecord::Base
  has_many :journals, :dependent => :delete_all
  has_many :invoices, :conditions => ['org_type = ?', 'Invoice'],
    :class_name => 'Journal'
  has_many :bills, :conditions => ['org_type = ?', 'Bill'],
    :class_name => 'Journal'
  has_many :transfers, :conditions => ['org_type = ?', 'Transfer'],
    :class_name => 'Journal'
  has_many :credit_card_charges,
    :conditions => ['org_type = ?', 'Credit Card Charge'],
    :class_name => 'Journal'
  has_many :bill_payments,
    :conditions => ['org_type = :ccard or org_type = :cheque', {:ccard => 'Bill Pmt -CCard', :cheque => 'Bill Pmt -Cheque'}],
    :class_name => 'Journal'
  has_many :deposits,
    :conditions => ['org_type = ?', 'Deposit'],
    :class_name => 'Journal'
  has_many :cheques,
    :conditions => ['org_type = ?', 'Cheque'],
    :class_name => 'Journal'
  has_many :general_journals,
    :conditions => ['org_type = ?', 'General Journal'],
    :class_name => 'Journal'
  has_many :payments,
    :conditions => ['org_type = ?', 'Payment'],
    :class_name => 'Journal'

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
    Ledger.create(journal_list)
  end

end
