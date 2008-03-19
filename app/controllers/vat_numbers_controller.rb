class VatNumbersController < ApplicationController

  skip_before_filter :get_business

  def show
    if params[:identifier] 
      params[:country_code] ||= params[:identifier].slice!(0..1)
    end
    temp_vat_number = VatNumber.new(params)
    respond_to do |format|
      if !temp_vat_number.valid?
        format.html { render :text => '<h1>Malformed VAT Number</h1>', 
          :status => :unprocessable_entity }
        format.xml { render :xml => temp_vat_number.errors,
          :status => :unprocessable_entity }
      elsif temp_vat_number.active?
        format.html { render :text => '<h1>Active</h1>' }
        format.xml { head :ok }
      else
        format.html { render :text => '<h1>Not Found</h1>',
          :status => :not_found }
        format.xml { head :not_found }
      end
    end
  end

end
