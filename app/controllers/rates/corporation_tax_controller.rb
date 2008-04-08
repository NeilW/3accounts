class Rates::CorporationTaxController < ApplicationController

  caches_page :index, :show

  def index
    @ct_rates=Rates::CorporationTax.find(:all)
    respond_to do |format|
      format.html
      format.xml do 
        render_xml_ct_rate("corporation_tax_rates")
      end
    end
  end

  def show
    @ct_rates=Rates::CorporationTax.find_by_fiscal_year_starting(params[:id])
    unless @ct_rates
      render_optional_error_file(:not_found)
    else
      respond_to do |format|
        format.html
        format.xml do 
          render_xml_ct_rate("corporation_tax_rate")
        end
      end
    end
  end

private

  def render_xml_ct_rate(root)
    render :xml => @ct_rates.to_xml(
      :root => root,
      :except => [:id, :updated_at, :created_at],
      :methods => :mscr_fraction
    ) 
  end

end
