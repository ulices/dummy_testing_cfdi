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
        format.json { render action: 'new', status: :created, location: @electronic_invoice }
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
        id:                   'UsuarioPruebasWS',
        password:             'b9ec2afa3361a59af4b4d102d3f704eabdf097d4',
        namespace:            'https://t2demo.facturacionmoderna.com/timbrado/soap',
        endpoint:             'https://t2demo.facturacionmoderna.com/timbrado/soap',
        wsdl:                 'https://t2demo.facturacionmoderna.com/timbrado/wsdl',
        log:                  false,
        ssl_verify_mode:      :none
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
