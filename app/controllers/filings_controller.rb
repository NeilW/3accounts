class FilingsController < ApplicationController

  def new
    @ledger = Ledger.new
  end
end
