class FilingsController < ApplicationController

  # GET /filings/
  def show
    redirect_to :action => :new
  end

  # GET /filings/new
  def new
  end

  # POST /filings/
  def create

    respond_to do |format|
      if Ledger.load_journals(Qb6JournalFile.new(params[:ledger][:upload_file]))
        flash[:notice] = 'Journals uploaded.'
      end
      format.html { render :action => "new" }
    end
  end

end
