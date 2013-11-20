class ElectronicInvoicesController < ApplicationController
  def index
    @electronic_invoices = ElectronicInvoice.all
  end

  def show
  end

  def new
    @electronic_invoice = ElectronicInvoice.new
  end

  def create
    @electronic_invoice = ElectronicInvoice.new(request: electronic_invoice_params.to_s)

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
         certificate:         File.open('./spec/fixtures/example_certificates/TUMG620310R95/TUMG620310R95_1210241209S.cer'),
         key:                 File.open('spec/fixtures/example_certificates/TUMG620310R95/TUMG620310R95_1210241209S.key.pem'),
         password:            '12345678a'
      },
      bill: {
        factura: {
          folio:              '101',
          serie:              'AA',
          fecha:              Time.now,
          formaDePago:        'Pago en una sola exhibicion',
          condicionesDePago:  'Contado',
          metodoDePago:       'Cheque',
          lugarExpedicion:    'San Pedro Garza Garcia, Nuevo Leon, Mexico',
          NumCtaPago:         'No identificado',
          moneda:             'MXN'
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
          rfc:                'TUMG620310R95',
          nombre:             'FACTURACION MODERNA SA DE CV',
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
            localidad:        'No se que sea esto, pero va',
            referencia:       'Sin Referencia',
            municipio:        'San Pedro Garza Garcia',
            estado:           'Nuevo Leon',
            pais:             'Mexico',
            codigoPostal:     '66220'
          },
          regimenFiscal:      'REGIMEN GENERAL DE LEY PERSONAS MORALES'
        },
        emisor_pass:          'billerpass',
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
end
