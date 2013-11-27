class ElectronicInvoicesController < ApplicationController
  before_action :set_electronic_invoice, only: :show

  def index
    @electronic_invoices = ElectronicInvoice.all
  end

  def show
  end

  def new
    @user = User.where(rfc: 'TUMG620310R95')
    @user_credentials = UserCredentialService.new @user
    @electronic_invoice = ElectronicInvoice.new
  end

  def create
    @electronic_invoice = ElectronicInvoice.new(request: electronic_invoice_params.to_s)
    @electronic_invoice.xml_response = request_to_stamp

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

  def electronic_invoice_params
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
         certificate:         @user_credentials.get_certificate,
         key:                 @user_credentials.get_key,
         password:            '12345678a'
      },
      bill: {
        factura: {
          folio:              params[:folio],
          serie:              params[:serie],
          fecha:              params[:fecha],
          formaDePago:        params[:forma_pago],
          condicionesDePago:  params[:condiciones_pago],
          metodoDePago:       params[:metodo_pago],
          lugarExpedicion:    params[:lugar_expedicion],
          NumCtaPago:         params[:numero_cuenta_pago],
          moneda:             params[:moneda]
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

  def request_to_stamp
    cfdi_response = FacturacionElectronica.create_cfdi electronic_invoice_params
    cfdi_response[:xml]
  end

end
