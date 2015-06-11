class ElectronicInvoicesController < ApplicationController
  before_action :set_electronic_invoice, only: :show

  def index
    @electronic_invoices = ElectronicInvoice.all
  end

  def show
  end

  def new
    @user = User.where(rfc: 'TUMG620310R95').first
    #@user_certificate = @user.certificate_url
    @electronic_invoice = ElectronicInvoice.new
  end

  def create
    @user = User.where(rfc: 'TUMG620310R95').first
    @electronic_invoice = ElectronicInvoice.new(request: electronic_invoice_params(params).to_s)
    @electronic_invoice.xml_response = request_to_stamp params

    respond_to do |format|
      if @electronic_invoice.save
        format.html { redirect_to @electronic_invoice, notice: 'Successfully' }
        format.json { render action: 'show', status: :created, location: @electronic_invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @electronic_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def electronic_invoice_params params
    {
      user_keys: {
        id:                   Rails.application.config.fm_id,
        password:             Rails.application.config.fm_password,
        namespace:            Rails.application.config.fm_namespace,
        endpoint:             Rails.application.config.fm_endpoint,
        wsdl:                 Rails.application.config.fm_wsdl,
        log:                  Rails.application.config.fm_log,
        ssl_verify_mode:      Rails.application.config.fm_ssl_verify_mode
      },
      pac_provider:           'FacturacionModerna',
      biller: {
         certificate:         File.open('./spec/fixtures/example_certificates/TUMG620310R95/TUMG620310R95_1210241209S.cer'), #@user_credentials.get_certificate,
         key:                 File.open('spec/fixtures/example_certificates/TUMG620310R95/TUMG620310R95_1210241209S.key.pem'),#@user_credentials.get_key,
         password:            '12345678a'
      },
      bill: {
        factura: {
          folio:              '101',
          serie:              'A',
          fecha:              Time.now,
          formaDePago:        'Pago en una sola exhibicion',
          condicionesDePago:  'Contado',
          metodoDePago:       'Efectivo',
          lugarExpedicion:    'San Pedro Garza Garcia, Nuevo Leon, Mexico',
          NumCtaPago:         '',
          moneda:             'MNX'
        },
        conceptos: [
          { cantidad:         3,
            unidad:           'PIEZA',
            descripcion:      'CAJA DE HOJAS BLANCAS TAMANO CARTA',
            valorUnitario:    450.00,
            importe:          1350.00
          },
          { cantidad:         8,
            unidad:           'PIEZA',
            descripcion:      'RECOPILADOR PASTA DURA 3 ARILLOS',
            valorUnitario:    18.50,
            importe:          148.00
          },
        ],
        emisor: {
          rfc:                @user.rfc,
          nombre:             @user.name,
          domicilioFiscal: {
            calle:            'RIO GUADALQUIVIR',
            noExterior:       '238',
            noInterior:       '314',
            colonia:          'ORIENTE DEL VALLE',
            localidad:        'No se que sea esto, pero va',
            referencia:       'Sin Referencia',
            municipio:        'San Pedro Garza Garcia',
            estado:           'Nuevo Leon',
            pais:             'Mexico',
            codigoPostal:     '66220'
          },
          expedidoEn: {
            calle:            'RIO GUADALQUIVIR',
            noExterior:       '238',
            noInterior:       '314',
            colonia:          'ORIENTE DEL VALLE',
            localidad:        'Monterrey',
            referencia:       'Sin Referencia',
            municipio:        'San Pedro Garza Garcia',
            estado:           'Nuevo Leon',
            pais:             'Mexico',
            codigoPostal:     '66220'
          },
          regimenFiscal:      'REGIMEN GENERAL DE LEY PERSONAS MORALES'
        },
        emisor_pass:          @user.pass_sat,
        cliente: {
          rfc:                'XAXX010101000',
          nombre:             'PUBLICO EN GENERAL',
          domicilioFiscal: {
            calle:            'CERRADA DE AZUCENAS',
            noExterior:       '109',
            colonia:          'REFORMA',
            municipio:        'Oaxaca de Juarez',
            estado:           'Oaxaca',
            pais:             'Mexico',
            codigoPostal:     '68050'
          }
        },
        impuestos: {
          impuesto:           'IVA'
        }
      }
    }
  end

  def set_electronic_invoice
    @electronic_invoice = ElectronicInvoice.find params[:id]
  end

  def request_to_stamp params
    cfdi_response = FacturacionElectronica.create_cfdi electronic_invoice_params params
    puts '='*100
    puts cfdi_response
    cfdi_response[:xml]
  end

end
