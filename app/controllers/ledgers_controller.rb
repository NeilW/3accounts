class LedgersController < ApplicationController
  layout 'filings'

  # GET /ledgers/
  def show
    redirect_to :action => :new
  end

  # GET /ledgers/new
  def new
    @ledger = Ledger.new
  end

  # POST /ledgers/
  def create

    respond_to do |format|
      number_of_journals = Ledger.load_journals(
        Qb6JournalFile.new(params[:ledger][:upload_file])
      )
      if number_of_journals.zero?
        flash[:error] = "No journals loaded from file. Have you already loaded them or picked the wrong file?"
      else
        flash[:notice] = "#{handle_singular(number_of_journals, 'Journal')} uploaded."
      end
      format.html { render :action => "new" }
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
