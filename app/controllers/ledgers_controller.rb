class LedgersController < ApplicationController
  layout 'filings'

  # GET /ledgers/
  def show
    @ledger = Ledger.find(:first)
    @journals = @ledger && @ledger.journals.paginate(:page => params[:page], :order => 'org_id', :per_page => 5)
    unless @journals
      flash[:error] = "You need to load some Journals first"
      redirect_to new_ledgers_url
    end
  end

  # GET /ledgers/new
  def new
    if Ledger.find(:first)
      flash[:error] = "Journals already loaded. If you want to replace them, please delete the current set first."
      redirect_to ledgers_url
    else
      @ledger = Ledger.new
    end
  end

  # DELETE /ledgers
  def destroy
    ledger = Ledger.find(params[:id])
    ledger.destroy
    respond_to do |format|
      format.html { redirect_to new_ledgers_url}
    end
  end


  # POST /ledgers/
  def create
    number_of_journals = Ledger.load_journals(
      Qb6JournalFile.new(params[:ledger][:upload_file])
    )
    if number_of_journals.zero?
      flash[:error] = "No journals loaded from file. Have you already loaded them or picked the wrong file?"
      redirect_to new_ledgers_url
    else
      flash[:notice] = "#{handle_singular(number_of_journals, 'Journal')} uploaded."
      redirect_to ledgers_url
    end
  end

  protected

  def handle_singular(number, word)
    if number == 1
      "#{number} #{word.singularize}"
    else
      "#{number} #{word.pluralize}"
    end
  end

end
