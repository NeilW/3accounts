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

class Qb6JournalFile
  include Enumerable

  # Need a file
  def initialize(from_file)
    @file = from_file
    @current_split = [ "" ] * 8
    get_columns
  end

  def name
    @file.path
  end

  def each
    @file.each_line do |line| 
      @current_split = split_line(line)
      if transaction_line? then
        @current_journal[:new_transactions] << create_transaction
      elsif journal_line? then
        @current_journal = create_journal
      elsif total_line? then
        yield @current_journal
      end
    end
    nil
  end

  def read_entry
    get_line_split
  end

  private

  def create_journal
    {
      :org_id => journal_id,
      :org_type => @current_split[1],
      :posted_at => iso_posted_date,
      :folio => @current_split[3],
      :name => @current_split[4],
      :new_transactions => [create_transaction]
    }
  end

  def transaction_line?
    journal_id.empty? && (
      credit_amount.empty? || debit_amount.empty?
    )
  end

  def total_line?
    !credit_amount.empty? && !debit_amount.empty? &&
    credit_amount.eql?('-'+debit_amount)
  end

  def journal_line?
    !journal_id.empty?
  end

  def splitter
    /[\t\r\n]/
  end

  def get_columns
    @columns ||= get_line_split
  end

  def get_line_split
    @file.readline.split(splitter)
  end

  def split_line(line)
    line.split(splitter)
  end

  def create_transaction
    {
    :memo => @current_split[5],
    :account => @current_split[6],
    :amount => get_amount
    }
  end

  def get_amount
    if debit_amount.empty?
      credit_amount
    else
      debit_amount
    end.gsub(/[^\d.-]/, '')
  end

  def credit_amount
    credit_value = @current_split[8]
    if credit_value.nil? || credit_value.empty?
      ""
    else
      "-" + credit_value
    end
  end

  def debit_amount
    @current_split[7] || ""
  end

  def journal_id
    @current_split[0] || ""
  end

  def iso_posted_date
    Date.strptime(@current_split[2], '%d/%m/%Y').strftime
  rescue
    ""
  end

end

