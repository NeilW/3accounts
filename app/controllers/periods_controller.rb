class PeriodsController < ApplicationController

  before_filter :get_journal
  layout 'filings'

  # GET periodics/:periodic_id/period
  def show
    redirect_to(edit_periodic_period_path(@journal))
  end

  # GET periodics/:periodic_id/period/new
  def new
    @period = Period.new(:start_at => @journal.posted_at, :end_at => @journal.posted_at)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @period }
    end
  end

  # GET periodics/:periodic_id/period/edit
  def edit
    @period = @journal.period
  end

  # POST /periodics/:periodic_id/period
  # POST /periods.xml
  def create
    @journal.period = Period.new(params[:period])
    @period = @journal.period

    respond_to do |format|
      if @period.save
        flash[:notice] = 'Period was successfully created.'
        format.html { redirect_to(periodics_path) }
        format.xml  { render :xml => @period, :status => :created, :location => journal_period_url }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @period.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT periodics/:periodic_id/period
  def update
    @period = @journal.period

    respond_to do |format|
      if @period.update_attributes(params[:period])
        flash[:notice] = 'Period was successfully updated.'
        format.html { redirect_to(periodics_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @period.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE periodics/:periodic_id/period
  def destroy
    @period = @journal.period
    @period.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = "Period was successfully removed."
        redirect_to(periodics_path)
      end
      format.xml  { head :ok }
    end
  end

  protected

  def get_journal
    @journal = Journal.find(params[:periodic_id])
  end

end
