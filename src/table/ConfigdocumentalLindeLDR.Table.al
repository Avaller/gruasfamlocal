/// <summary>
/// Table Config. documental - Linde_LDR (ID 50205)
/// </summary>
table 50205 "Config. documental - Linde_LDR"
{
    Caption = 'Documental Config.';

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; Fact_Logo_cab_G_color; BLOB)
        {
            Caption = 'Bill Logo - Big size & Colour';
            Description = 'Imagen de logo de factura. Tamaño grande y formato Color';
            SubType = Bitmap;
        }
        field(3; Fact_Logo_cab_G_BN; BLOB)
        {
            Caption = 'Bill Logo - Big size & BG';
            Description = 'Imagen de logo de factura. Tamaño grande y formato B/N';
            SubType = Bitmap;
        }
        field(4; Fact_Logo_cab_P_color; BLOB)
        {
            Caption = 'Bill Logo - Small size & Colour';
            Description = 'Imagen de logo de factura. Tamaño pequeño y formato Color';
            SubType = Bitmap;
        }
        field(5; Fact_Logo_cab_P_BN; BLOB)
        {
            Caption = 'Bill Logo - Small size & BG';
            Description = 'Imagen de logo de factura. Tamaño pequeño y formato B/N';
            SubType = Bitmap;
        }
        field(6; Fact_Logo_pie_color; BLOB)
        {
            Caption = 'Invoice Bottom Color Logo';
            Description = 'Imagen de pie de página a color.';
            SubType = Bitmap;
        }
        field(7; Fact_Logo_pie_BN; BLOB)
        {
            Caption = 'Invoice Bottom B/N Logo';
            Description = 'Imagen de pie de página en B/N.';
            SubType = Bitmap;
        }
        field(8; HT_Logo_cab_G_color; BLOB)
        {
            Caption = 'Worksheet Logo - Big size & Colour';
            Description = 'Imagen de logo de hoja de trabajo. Tamaño grande y formato Color.';
            SubType = Bitmap;
        }
        field(9; HT_Logo_cab_G_BN; BLOB)
        {
            Caption = 'Worksheet Logo - Big size & BG';
            Description = 'Imagen de logo de hoja de trabajo. Tamaño grande y formato B/N';
            SubType = Bitmap;
        }
        field(10; HT_Logo_cab_P_color; BLOB)
        {
            Caption = 'Worksheet Logo - Small size & Colour';
            Description = 'Imagen de logo de hoja de trabajo. Tamaño pequeño y formato Color.';
            SubType = Bitmap;
        }
        field(11; HT_Logo_cab_P_BN; BLOB)
        {
            Caption = 'Worksheet Logo - Small size & BG';
            Description = 'Imagen de logo de hoja de trabajo. Tamaño pequeño y formato B/N.';
            SubType = Bitmap;
        }
        field(12; HT_Logo_certi; BLOB)
        {
            Caption = 'WorkSheet Bottom Color Logo';
            Description = 'Imagen de logo Hoja de trabajo. Certificaciones.';
            SubType = Bitmap;
        }
        field(13; HT_Imag_direcciones; BLOB)
        {
            Caption = 'WorkSheet Bottom B/N Logo';
            Description = 'Imagen de direcciones en Hoja de trabajo.';
            SubType = Bitmap;
        }
        field(14; C_Logo_cab_olor; BLOB)
        {
            Caption = 'Contract Logo - Big size & Colour';
            Description = 'Imagen de logo de Contratos. Tamaño grande y formato Color.';
            SubType = Bitmap;
        }
        field(15; C_Logo_cab_G_BN; BLOB)
        {
            Caption = 'Contract Logo - Big size & BG';
            Description = 'Imagen de logo de Contratos. Tamaño grande y formato BN.';
            SubType = Bitmap;
        }
        field(16; C_Logo_cab_P_color; BLOB)
        {
            Caption = 'Contract Logo - Small size & Colour';
            Description = 'Imagen de logo de Contratos. Tamaño pequeño y formato Color.';
            SubType = Bitmap;
        }
        field(17; C_Logo_cab_P_BN; BLOB)
        {
            Caption = 'Contract Logo - Small size & BG';
            Description = 'Imagen de logo de Contratos. Tamaño pequeño y formato BN.';
            SubType = Bitmap;
        }
        field(18; C_Logo_certi; BLOB)
        {
            Caption = 'Contract Logo - Certificate';
            Description = 'Imagen de logo de Contratos. Certificaciones.';
            SubType = Bitmap;
        }
        field(19; C_Imag_direcciones; BLOB)
        {
            Caption = 'Contract Logo - Address';
            Description = 'Imagen de direcciones en Contratos.';
            SubType = Bitmap;
        }
        field(20; P_Logo_cab_G_color; BLOB)
        {
            Caption = 'Budget Logo - Big size & Colour';
            Description = 'Imagen de logo de Presupuestos. Tamaño grande y formato Color.';
            SubType = Bitmap;
        }
        field(21; P_Logo_cab_G_BN; BLOB)
        {
            Caption = 'Budget Logo - Big size & BG';
            Description = 'Imagen de logo de Presupuestos. Tamaño grande y formato BN.';
            SubType = Bitmap;
        }
        field(22; P_Logo_cab_P_color; BLOB)
        {
            Caption = 'Budget Logo - Small size & Colour';
            Description = 'Imagen de logo de Presupuestos. Tamaño pequeño y formato Color.';
            SubType = Bitmap;
        }
        field(23; P_Logo_cab_P_BN; BLOB)
        {
            Caption = 'Budget Logo - Small size & BG';
            Description = 'Imagen de logo de Presupuestos. Tamaño pequeño y formato BN';
            SubType = Bitmap;
        }
        field(24; P_Logo_certi; BLOB)
        {
            Caption = 'Budget Logo - Certificate';
            Description = 'Imagen de logo de Presupuestos. Certificaciones.';
            SubType = Bitmap;
        }
        field(25; P_Imag_direcciones; BLOB)
        {
            Caption = 'Budget Logo - Address';
            Description = 'Imagen de direcciones en Presupuestos.';
            SubType = Bitmap;
        }
        field(26; Imagen_Top; BLOB)
        {
            Caption = 'Top Imagen of Report';
            Description = 'Imagen temporal para la cabecera de los informes.';
            SubType = Bitmap;
        }
        field(27; "Plantilla Oferta Alquiler"; BLOB)
        {
            Caption = 'Quote Rent Pattern';
            Description = 'Plantilla para el documento Oferta de Alquiler';
            SubType = Bitmap;
        }
        field(28; Imagen_Down; BLOB)
        {
            Caption = 'Down Image';
            Description = 'Imagen temporal para el pie de página de los informes';
            SubType = Bitmap;
        }
        field(29; "Plantilla Contrato Alquiler C"; BLOB)
        {
            Caption = 'Rent Contract Pattern';
            Description = 'Plantilla para el documento de Contrato de Alquiler Firmado a Corto Plazo';
            SubType = Bitmap;
        }
        field(30; "Plantilla Mantenimiento FS"; BLOB)
        {
            Caption = 'Full Service Maintenance Pattern';
            Description = 'Plantilla para el documento de Contrato de Mantenimiento Full Service';
            SubType = Bitmap;
        }
        field(31; "Plantilla Reparacion"; BLOB)
        {
            Caption = 'Repair Budget Pattern';
            Description = 'Plantilla para el documento de Presupuesto de Reparacion';
            SubType = Bitmap;
        }
        field(32; "Plantilla Lista Reparacion"; BLOB)
        {
            Caption = 'Repair List Pattern';
            Description = 'Plantilla para el documento de lista de Materiales del Presupuesto de Reparacion';
            SubType = Bitmap;
        }
        field(33; "Ruta Oferta Alquiler"; Text[250])
        {
            Caption = 'Rent Quote Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir la Oferta de Alquiler';
        }
        field(34; "Ruta Contrato Alquiler Corto"; Text[250])
        {
            Caption = 'Rent Contract Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir el Contrato de Alquiler a Corto';
        }
        field(35; "Ruta Contrato Mantenimiento"; Text[250])
        {
            Caption = 'Maintenance Contract Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir el Contrato de Mantenimiento';
        }
        field(36; "Ruta Oferta Reparacion"; Text[250])
        {
            Caption = 'Repair Quote Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir la Oferta de Reparacion';
        }
        field(37; Alb_Logo_cab_G_color; BLOB)
        {
            Caption = 'Shipment Logo - Big size & Colour';
            Description = 'Imagen de logo de albaran. Tamaño grande y formato Color';
            SubType = Bitmap;
        }
        field(38; Alb_Logo_cab_G_BN; BLOB)
        {
            Caption = 'Shipment Logo - Big size & BG';
            Description = 'Imagen de logo de albaran. Tamaño grande y formato B/N';
            SubType = Bitmap;
        }
        field(39; Alb_Logo_cab_P_color; BLOB)
        {
            Caption = 'Shipment Logo - Small size & Colour';
            Description = 'Imagen de logo de albaran. Tamaño pequeño y formato Color';
            SubType = Bitmap;
        }
        field(40; Alb_Logo_cab_P_BN; BLOB)
        {
            Caption = 'Shipment Logo - Small size & BG';
            Description = 'Imagen de logo de albaran. Tamaño pequeño y formato B/N';
            SubType = Bitmap;
        }
        field(41; Alb_Logo_pie_color; BLOB)
        {
            Caption = 'Shipment Bottom Color Logo';
            Description = 'Imagen de pie de página de albaran a color.';
            SubType = Bitmap;
        }
        field(42; Alb_Logo_pie_BN; BLOB)
        {
            Caption = 'Shipment Bottom B/N Logo';
            Description = 'Imagen de pie de página de albaran en B/N.';
            SubType = Bitmap;
        }
        field(43; Clausula_Nota_Alb_venta; Text[250])
        {
            Caption = 'Sales Shipment Down Note';
            Description = 'Nota al pie en los Albaranes de Venta.';
        }
        field(44; "Plantilla Contrato Alquiler L"; BLOB)
        {
            Caption = 'Rent Contract Pattern';
            Description = 'Plantilla para el documento de Contrato de Alquiler Firmado a Largo Plazo';
            SubType = Bitmap;
        }
        field(45; "Ruta Contrato Alquiler Largo"; Text[250])
        {
            Caption = 'Rent Contract Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir el Contrato de Alquiler a Largo';
        }
        field(46; "Plantilla Oferta Mantenimiento"; BLOB)
        {
            Caption = 'Full Service Maintenance Pattern';
            Description = 'Plantilla para el documento de Oferta de Contrato de Mantenimiento Full Service';
            SubType = Bitmap;
        }
        field(47; "Ruta Oferta Contrato Mant"; Text[250])
        {
            Caption = 'Maintenance Offer Contract Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir Ofertas de Contrato de Mantenimiento';
        }
        field(48; Clausula_Nota_Hoja_Serv; Text[250])
        {
            Caption = 'WorkSheet Down Note';
            Description = 'Nota al pie en las hojas de servicio.';
        }
        field(49; HT_Logo_pie_color; BLOB)
        {
            Caption = 'Worksheet Bottom Color Picture';
            Description = 'Imagen de logo de hoja de trabajo. Tamaño grande y formato Color.';
            SubType = Bitmap;
        }
        field(50; HT_Logo_pie_BN; BLOB)
        {
            Caption = 'Worksheet Bottom B/W Picture';
            Description = 'Imagen de logo de hoja de trabajo. Tamaño grande y formato B/N.';
            SubType = Bitmap;
        }
        field(51; Finan_Logo_cab_G_color; BLOB)
        {
            Caption = 'Financial Reports Picture';
            Description = 'Imagen logo informes Financieros';
            SubType = Bitmap;
        }
        field(52; "Ruta Albaranes Maquina"; Text[250])
        {
            Caption = 'Machine Shipment Path';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir los Albaranes';
        }
        field(53; "Plantilla Maquina"; BLOB)
        {
            Caption = 'Machine Template';
            Description = 'Plantilla para el documento de Albaran de Maquina';
            SubType = Bitmap;
        }
        field(54; Clausula_Nota_Ped_Compra; Text[250])
        {
            Caption = 'Puch. Order Down Note';
            Description = 'Nota al pie en los pedidos de compra';
        }
        field(56; "Plantilla Documento Control"; BLOB)
        {
            Caption = 'Control Document Template';
            Description = 'Plantilla para el documento de Documento de control de transporte de mercancias por carretera';
            SubType = Bitmap;
        }
        field(57; "Contract Invoce Word Template"; BLOB)
        {
            Caption = 'Invoce Word Template';
            Description = 'Plantilla para la factura word';
            SubType = Bitmap;
        }
        field(58; "Ruta facturas word"; Text[250])
        {
            Caption = 'Word Contract Invoice Directory';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir las facturas word';
        }
        field(59; "Attached Word Template"; BLOB)
        {
            Caption = 'Attached Invoce Word Template';
            Description = 'Plantilla para la factura word';
            SubType = Bitmap;
        }
        field(60; "Attached Comp. Word Template"; BLOB)
        {
            Caption = 'Attached Component Invoce Word Template';
            Description = 'Plantilla para la factura word';
            SubType = Bitmap;
        }
        field(61; "Plantilla Productos Proveedor"; BLOB)
        {
            Caption = 'Vendor Item Template';
            Description = 'Plantilla para el documento de Albaran de Productos';
            SubType = Bitmap;
        }
        field(62; "Ruta Albaranes Producto Prov."; Text[250])
        {
            Caption = 'Vendor Item Shipment Path';
            Description = 'Ruta donde se almacenan los temporales generados al imprimir los Albaranes';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}