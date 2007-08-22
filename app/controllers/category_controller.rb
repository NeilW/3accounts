class CategoryController < ApplicationController
  def add
    Category.new(params[:category]).save
    @categories= Category.find(:all)
     if !params[:selected_account_id].nil?
	@selected_account_id = params[:selected_account_id]
    end
    #render :partial => "/category/list"
  end
  
  def delete
    Category.find(params[:id]).destroy
     if !params[:selected_account_id].nil?
	redirect_to :controller => :admin, :action => :account, :id =>params[:selected_account_id]
    else
	redirect_to :controller => :admin, :action => :index
    end
  end
end
