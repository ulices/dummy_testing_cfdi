class AddFiscalDataToElectronicInvoice < ActiveRecord::Migration
  def change
    add_column :electronic_invoices, :folio, :string
    add_column :electronic_invoices, :serie, :string
    add_column :electronic_invoices, :fecha, :datetime
    add_column :electronic_invoices, :forma_pago, :string
    add_column :electronic_invoices, :condiciones_pago, :string
    add_column :electronic_invoices, :metodo_pago, :string
    add_column :electronic_invoices, :expedido, :string
    add_column :electronic_invoices, :numero_cuenta_pago, :string
    add_column :electronic_invoices, :moneda, :string
  end
end
