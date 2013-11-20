class ElectronicInvoicesController < ApplicationController
  def index
    ElectronicInvoice.all
  end

  def new
  end
end
