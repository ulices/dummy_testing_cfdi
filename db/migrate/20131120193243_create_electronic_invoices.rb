class CreateElectronicInvoices < ActiveRecord::Migration
  def change
    create_table :electronic_invoices do |t|
      t.string :request
      t.string :xml_response
      t.string :txt_stamp
      t.string :cbb

      t.timestamps
    end
  end
end
