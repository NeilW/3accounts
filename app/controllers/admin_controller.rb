class AdminController < ApplicationController
  before_filter :login_required
  def index
    @accounts = Account.find(:all)
    @categories = Category.find(:all)
  end

  def account
    @accounts = Account.find(:all)
    @categories = Category.find(:all)
    @selected_account = Account.find(params[:id])
  end

  def cleanup
  	Account.destroy_all
	Category.destroy_all
	Entry.destroy_all
	redirect_to :controller => :admin, :action => :index
  end

end
