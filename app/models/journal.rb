class Journal < ActiveRecord::Base
  has_many :transactions
  belongs_to :ledger

  def new_transactions=(transaction_list)
    transaction_list.each do |transaction|
      transactions.build transaction
    end
  end

end
