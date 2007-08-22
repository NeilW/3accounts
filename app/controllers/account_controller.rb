class AccountController < ApplicationController
  def add
    Account.new(params[:account]).save
    if !params[:selected_account_id].nil?
    	@selected_account = Account.find(params[:selected_account_id])
    end
    @accounts = Account.find(:all)
    render :partial => "/account/list"
  end

  def delete
    Account.find(params[:id]).destroy
    redirect_to :controller => :admin, :action => :index
  end

  def export_csv
    account = Account.find(params[:id])
    entries = account.entries
    csv_string = FasterCSV.generate(:col_sep => ";") do |csv|
       csv << ["Checked", "Date", "Category", "Comment", "Check number", "Value"]
       for entry in entries
           csv << [entry.checked,entry.effective_date,entry.category.name,entry.comment,entry.check_number,entry.value]
       end
    end
    filename = account.name+"_"+Time.now.to_date.to_s+".csv"
    send_data(csv_string,
          :type => 'text/csv; charset=utf-8; header=present',
          :filename => filename)
  end
end
