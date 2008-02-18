class Rates::CorporationTaxController < ApplicationController

  def index
    @ct_rates=CorporationTax.find(:all)

    respond_to do |format|
      format.html
      format.xml { render :xml => @ct_rates.to_xml(:root => "corporation_tax_rates", :except => [:id, :updated_at, :created_at], :methods => :mscr_fraction) }
    end
  end

end
