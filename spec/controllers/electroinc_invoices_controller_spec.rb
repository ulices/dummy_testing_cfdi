require 'spec_helper'

describe ElectronicInvoicesController do
  describe '#index' do
    before do 
      get :index
    end

    specify do
      expect(response).to be_success
    end
  end

  describe '#new' do
    before do
      get :new
    end

    specify do
      expect(response).to be_success
    end
  end
end
