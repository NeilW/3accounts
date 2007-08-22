class EntryController < ApplicationController
  def add
    @newEntry = Entry.new(params[:entry])
    @newEntry.save
    @selected_account = @newEntry.account
  end

  def update
    @entry = Entry.find(params[:id])
    @selected_account = @entry.account
    @categories = Category.find(:all)
    @updating = true
  end

  def save_update
    @entry = Entry.find(params[:id])
    @old_entry_effective_date = @entry.effective_date
    @simple_update = false 
    @success = false
    if @entry.update_attributes(params[:entry])
      @success = true
      @selected_account = @entry.account
      @categories = Category.find(:all)
      if (@old_entry_effective_date <= Time.now.to_date) && (@entry.effective_date <= Time.now.to_date)
      	@simple_update = true
      end
    end
  end

  def cancel_update
    @entry = Entry.new
    @selected_account = Account.find(params[:id])
    @categories = Category.find(:all)
    render :template => "/entry/update"
  end

  def delete_update
    entry = Entry.find(params[:id])
    @entry_id = params[:id]
    @entry_effective_date = entry.effective_date
    @selected_account = entry.account
    entry.destroy 
    @categories = Category.find(:all)
  end

  def switch_checked
   entry = Entry.find(params[:id])
   entry.checked = ! entry.checked
   entry.save
   render :nothing => true
  end
  
end
