require 'qb_6_journal_file'
class Ledger < ActiveRecord::Base
  has_many :journals
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
