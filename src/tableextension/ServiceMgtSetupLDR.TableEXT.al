/// <summary>
/// tableextension 50071 "Service Mgt. Setup_LDR"
/// </summary>
tableextension 50071 "Service Mgt. Setup_LDR" extends "Service Mgt. Setup"
{
    fields
    {
        field(50000; "Linde Vendor No._LDR"; Code[20])
        {
            Caption = 'Nº Proveedor Linde';
            DataClassification = ToBeClassified;
            Description = 'Nº Proveedor Linde';
            TableRelation = "Vendor";
        }
        field(50001; "Disp. Time Unit Of Measure_LDR"; Code[20])
        {
            Caption = 'Unidad Medida Tiempo de Desplazamiento';
            DataClassification = ToBeClassified;
            Description = 'Horas de Desplazamiento';
            TableRelation = "Unit of Measure";
        }
        field(50002; "Displacement Unit Of Measure_LDR"; Code[20])
        {
            Caption = 'Unidad Medida Desplazamiento';
            DataClassification = ToBeClassified;
            Description = 'Unidad de desplazamiento';
            TableRelation = "Unit of Measure";
        }
        field(50003; "Periodic Service Order Type_LDR"; Code[20])
        {
            Caption = 'Tipo Pedido Servicio Periódico';
            DataClassification = ToBeClassified;
            Description = 'Indica el Tipo de Pedido de Servicio Mantenimiento';
            TableRelation = "Service Order Type"."Code";
        }
        field(50004; "In Location_LDR"; Code[20])
        {
            Caption = 'Almacén Entrada';
            DataClassification = ToBeClassified;
            Description = 'Almacén Entrada';
            TableRelation = "Location";
        }
        field(50005; "No. of hours in day_LDR"; Decimal)
        {
            Caption = 'Nº Horas por Día';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas por Día';
        }
        field(50006; "No. of days in week_LDR"; Decimal)
        {
            Caption = 'Nº Días por Semana';
            DataClassification = ToBeClassified;
            Description = 'Nº Días por Semana';
        }
        field(50007; "No. of days in Month_LDR"; Decimal)
        {
            Caption = 'Nº Días por Mes';
            DataClassification = ToBeClassified;
            Description = 'Nº Días por Mes';
        }
        field(50008; "No. of months in year_LDR"; Decimal)
        {
            Caption = 'Nº Meses al Año';
            DataClassification = ToBeClassified;
            Description = 'Nº Meses al Año';
        }
        field(50009; "No. of weeks in year_LDR"; Decimal)
        {
            Caption = 'Nº Semanas al Año';
            DataClassification = ToBeClassified;
            Description = 'Nº Semanas al Año';
        }
        field(50010; "No. of days in year_LDR"; Decimal)
        {
            Caption = 'Nº Días al Año';
            DataClassification = ToBeClassified;
            Description = 'Nº Días al Año';
        }
        field(50011; "No. of hours in year_LDR"; Decimal)
        {
            Caption = 'Nº Horas al Año';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas al Año';
        }
        field(50012; "Assembly Service Order Type_LDR"; Code[20])
        {
            Caption = 'Tipo Pedido Servicio Montaje';
            DataClassification = ToBeClassified;
            Description = 'Indica el Tipo de Pedido de Servicio Montaje';
            TableRelation = "Service Order Type"."Code";
        }
        field(50013; "Person in charge of warranty_LDR"; Code[20])
        {
            Caption = 'Responsable de la Garantía de Post-Venta';
            DataClassification = ToBeClassified;
            Description = 'Indica el Código del Responsable de Post-Venta';
            TableRelation = "Resource"."No.";
        }
        field(50014; "Warranty Nos._LDR"; Code[20])
        {
            Caption = 'Nº Serie Garantía';
            DataClassification = ToBeClassified;
            Description = 'Nº Serie Garantía';
            TableRelation = "No. Series";
        }
        field(50015; "Work Time Unit Of Measure_LDR"; Code[20])
        {
            Caption = 'Unidad Medida Tiempo de Trabajo';
            DataClassification = ToBeClassified;
            Description = 'Horas de trabajo';
            TableRelation = "Unit of Measure";
        }
        field(50016; "Status Dimension_LDR"; Code[20])
        {
            Caption = 'Dimensión Estado';
            DataClassification = ToBeClassified;
            Description = 'Dimensión Estado';
            TableRelation = "Dimension";
        }
        field(50017; "New Dimension Value_LDR"; Code[20])
        {
            Caption = 'Valor "Nuevo" Dimensión Estado';
            DataClassification = ToBeClassified;
            Description = 'Valor "Nuevo" Dimensión Estado';
            TableRelation = "Dimension Value"."Code" WHERE("Dimension Code" = FIELD("Status Dimension_LDR"));
        }
        field(50018; "Used Dimension Value_LDR"; Code[20])
        {
            Caption = 'Valor "Usado" Dimensión Estado';
            DataClassification = ToBeClassified;
            Description = 'Valor "Usado" Dimensión Estado';
            TableRelation = "Dimension Value"."Code" WHERE("Dimension Code" = FIELD("Status Dimension_LDR"));
        }
        field(50019; "Component In Location_LDR"; Code[20])
        {
            Caption = 'Almacén Entrada Componentes';
            DataClassification = ToBeClassified;
            Description = 'Almacén Entrada Componentes';
            TableRelation = "Location";
        }
        field(50020; "Warranty Vendor No._LDR"; Code[20])
        {
            Caption = 'Nº Proveedor Garantías';
            DataClassification = ToBeClassified;
            Description = 'Nº Proveedor Garantías';
            TableRelation = "Vendor";
        }
        field(50021; "Serv. Contract Inv. Group Nos._LDR"; Code[10])
        {
            Caption = 'Nº Serie Grupo Facturación Contracto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50022; "A/F Location_LDR"; Code[20])
        {
            Caption = 'Almacén Activos Fijos';
            DataClassification = ToBeClassified;
            Description = 'Almacén Activos Fijos';
            TableRelation = "Location";
        }
        field(50023; "Group Displacement on Invoices_LDR"; Boolean)
        {
            Caption = 'Agrupar Desplazamiento en Facturas';
            DataClassification = ToBeClassified;
        }
        field(50024; "Default Customer Sales Code_LDR"; Code[20])
        {
            Caption = 'Código Ventas Cliente por Defecto';
            DataClassification = ToBeClassified;
            TableRelation = "Standard Sales Code";
        }
        field(50025; "Resp. Center Dim._LDR"; Code[20])
        {
            Caption = 'Dimensión Centro Responsabilidad';
            DataClassification = ToBeClassified;
            Description = 'Dimensión Tipo de Máquina';
            TableRelation = "Dimension";
        }
        field(50026; "Internal Contract Nos._LDR"; Code[20])
        {
            Caption = 'Nº Serie Contrato Interno';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50027; "No. Internal Customer_LDR"; Code[20])
        {
            Caption = 'Nº Cliente Interno';
            DataClassification = ToBeClassified;
            TableRelation = "Customer"."No.";
        }
        field(50028; "Machine Type Dimension_LDR"; Code[20])
        {
            Caption = 'Dimensión Tipo Máquina';
            DataClassification = ToBeClassified;
            Description = 'Dimensión Tipo de Máquina';
            TableRelation = "Dimension";
        }
        field(50029; "Not to detract Serv. Item_LDR"; Boolean)
        {
            Caption = 'No Depreciar el PS con Amortizaciones';
            DataClassification = ToBeClassified;
        }
        field(50030; "Sales Price Mandatory_LDR"; Boolean)
        {
            Caption = 'Obligatorio Introducir PVP';
            DataClassification = ToBeClassified;
            Description = 'Campo para Obligar a Introducir PVP en los Pedidos de Servicio.';
        }
        field(50031; "AO Dim Code_LDR"; Code[20])
        {
            Caption = 'Dimensión Áreas Origen';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension";
        }
        field(50032; "AD Dim Code_LDR"; Code[20])
        {
            Caption = 'Dimensión Áreas Destino';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension";
        }
        field(50033; "Price/Km Advanced Calc_LDR"; Boolean)
        {
            Caption = 'Cálculo Avanzado Precio/Km';
            DataClassification = ToBeClassified;
        }
        field(50034; "Res. Center Mandatory_LDR"; Boolean)
        {
            Caption = 'Centro Resp. Obligatorio';
            DataClassification = ToBeClassified;
        }
        field(50035; "MI Contract_LDR"; Code[20])
        {
            Caption = 'Contrato MI';
            DataClassification = ToBeClassified;
        }
        field(50036; "MII Contract_LDR"; Code[20])
        {
            Caption = 'Contrato MII';
            DataClassification = ToBeClassified;
        }
        field(50037; "FS Contract_LDR"; Code[20])
        {
            Caption = 'Contrato FS';
            DataClassification = ToBeClassified;
        }
        field(50038; "Journal Book Name_LDR"; Code[20])
        {
            Caption = 'Nombre Libro Diario';
            DataClassification = ToBeClassified;
        }
        field(50039; "Journal Batch Name_LDR"; Code[20])
        {
            Caption = 'Nombre Sección Diario';
            DataClassification = ToBeClassified;
        }
        field(50040; "General Resource Mantenaince_LDR"; Code[20])
        {
            Caption = 'Recurso General Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Recurso Genérico que se utilizará para el DataPort de Plantillas de Mantenimiento';
            TableRelation = "Resource"."No.";
        }
        field(50041; "Update Maint. Template Log_LDR"; Text[210])
        {
            Caption = 'Log Actualización Plantillas Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Ruta donde se Almacenará el Fichero de Log de la Actualización de Plantillas de Máquinas y Contratos';
        }
        field(50042; "Default Maint. Template No._LDR"; Integer)
        {
            Caption = 'Nº Plantilla Mantenimiento por Defecto';
            DataClassification = ToBeClassified;
            MaxValue = 6;
            MinValue = 1;
        }
        field(50043; "Last File Loaded_LDR"; Text[250])
        {
            Caption = 'Útimo Fichero Cargado';
            DataClassification = ToBeClassified;
            Description = 'Ruta y Nombre del Último Fichero Cargado';
            Editable = false;
        }
        field(50044; "Last File Loaded Date_LDR"; Date)
        {
            Caption = 'Fecha Último Fichero Cargado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50045; "Ext.Hours Control Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Control Horas Externos';
            DataClassification = ToBeClassified;
            Description = 'Control de Horas';
            //TableRelation = Table7122020 WHERE(Field4 = CONST(1)); //TODO: Revisar si conservamos la tabla
        }
        field(50046; "Int.Hours Control Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Control Horas Internos';
            DataClassification = ToBeClassified;
            Description = 'Control de Horas';
            //TableRelation = Table7122020 WHERE(Field4 = CONST(0)); //TODO: Revisar si conservamos la tabla
        }
        field(50047; "Direct Sales Serv. Order Type_LDR"; Code[20])
        {
            Caption = 'Tipo Pedido Servicio Venta Directa';
            DataClassification = ToBeClassified;
            TableRelation = "Service Order Type";
        }
        field(50048; "Direct Sales Serv. Order Desc_LDR"; Text[50])
        {
            Caption = 'Descripción Servicio Venta Directa';
            DataClassification = ToBeClassified;
        }
        field(50049; "KPI Destination Folder_LDR"; Text[250])
        {
            Caption = 'Carpeta Destino KPI';
            DataClassification = ToBeClassified;
            Description = 'Ruta Donde se Genera el Fichero de KPI.';
        }
        field(50050; "Transfer Displacement / KM_LDR"; Option)
        {
            Caption = 'Cálculo Desplazamientos Transfer';
            DataClassification = ToBeClassified;
            OptionCaption = 'Ida,Ida y Vuelta';
            OptionMembers = "Way","Way Back";
        }
        field(50051; "Basic Response Times_LDR"; Boolean)
        {
            Caption = 'Cálculo Básico Tiempos de Respuesta';
            DataClassification = ToBeClassified;
            Description = 'Indica si se utiliza la Funcionalidad Avanzada de Cálculo de Tiempos de Respuesta *OBSOLETO*';
        }
        field(50052; "Check Displacement Calculation_LDR"; BoolEAN)
        {
            Caption = 'Testear Cálculo Desplazamiento / Distancia / Duración';
            DataClassification = ToBeClassified;
            Description = 'Indica si se utiliza la Funcionalidad Avanzada de Cálculo de Tiempos de Respuesta';
        }
        field(50053; "Calculate Maint._LDR"; Option)
        {
            Caption = 'Tipo Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Tipo de Cálculo que se Utilizará para Sacar las Horas/Día de una Máquina';
            OptionCaption = 'Según Contrato,Por Período,Por Nº Pedidos';
            OptionMembers = "Según Contrato","Por Período","Por Nº Pedidos";
        }
        field(50054; "Calculate Maint. Type Period_LDR"; DateFormula)
        {
            Caption = 'Período Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Período que se utilizará para el Cálculo de Horas/Día de una Máquina por Período';
        }
        field(50055; "Calculate Maint. Type Order_LDR"; Integer)
        {
            Caption = 'Nº Pedidos Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Pedidos que se utilizarán para el Cálculo de Horas/Día de una Máquina por Pedidos Servicio';
            MinValue = 0;
            NotBlank = true;
        }
        field(50056; "Not Service Orders Active_LDR"; Boolean)
        {
            Caption = 'Excluye Pedidos Servicio Activos';
            DataClassification = ToBeClassified;
            Description = 'Indica si está marcado que no se tendrán en cuenta los Pedidos de Servicio Terminados Activos';
        }
        field(50057; "Auto Adjust Journal Template_LDR"; Code[20])
        {
            Caption = 'Plantilla Diario Auto Ajustes';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50058; "Auto Adjust Journal Batch_LDR"; Code[20])
        {
            Caption = 'Sección Diario Auto Ajustes';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("Auto Adjust Journal Template_LDR"));
        }
        field(50059; "Auto Adjust S. Item Jnl. Tmpl._LDR"; Code[20])
        {
            Caption = 'Plantilla Diario Auto Ajustes Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50060; "Auto Adjust S. Item Jnl. Bach._LDR"; Code[20])
        {
            Caption = 'Sección Diario Auto Ajustes Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("Auto Adjust S. Item Jnl. Tmpl._LDR"));
        }
        field(50061; "WorkLoad Jnl. Tmpl._LDR"; Code[20])
        {
            Caption = 'Plantilla Diario Parte Trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Res. Journal Template";
        }
        field(50062; "WorkLoad Jnl. Batch._LDR"; Code[20])
        {
            Caption = 'Sección Diario Parte Trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Res. Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("WorkLoad Jnl. Tmpl._LDR"));
        }
        field(50063; "S.Item Bin Entry Default Batch_LDR"; Code[20])
        {
            Caption = 'Sección Diario Movimientos Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = Table7122035.Field2; //TODO: Revisar si conservamos la tabla

            trigger OnLookup()
            var
                SourceCodeSetup: Record "Source Code Setup";
            //BatchTable: Record 7122035;
            //BatchForm: Page 7122054;
            begin
                SourceCodeSetup.Get();
                SourceCodeSetup.TestField(SourceCodeSetup."Service Item Entry Journal_LDR");

                // Clear(BatchTable);
                // BatchTable.SetRange(BatchTable."Journal Template Name", SourceCodeSetup."Service Item Entry Journal");
                // if BatchTable.FindSet() then;
                // BatchForm.SetTableView(BatchTable);
                // BatchForm.LookupMode := true;
                // if BatchForm.RunModal = Action::LookupOK then begin
                //     BatchForm.GetRecord(BatchTable);
                //     "S.Item Bin Entry Default Batch" := BatchTable.Name;
                // end;
            end;
        }
        field(50064; "Assembly Work Type Code_LDR"; Code[10])
        {
            Caption = 'Código Tipo Trabajo Montaje';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type"."Code";
        }
        field(50065; "Assembly No. Series_LDR"; Code[10])
        {
            Caption = 'Nº Serie PS Montaje';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series"."Code";
        }
        field(50066; "Show Delivery Contract Invoice_LDR"; Boolean)
        {
            Caption = 'Muestra Información Entrega en Facturas Contrato';
            DataClassification = ToBeClassified;
        }
        field(50067; "Assembly Fault Reason Code_LDR"; Code[10])
        {
            Caption = 'Código Razón Defecto Montaje';
            DataClassification = ToBeClassified;
            TableRelation = "Fault Reason Code";
        }
        field(50068; "Materials pending state_LDR"; Code[20])
        {
            Caption = 'Estado Pendiente Material';
            DataClassification = ToBeClassified;
            TableRelation = "Repair Status";
        }
        field(50069; "No. Internal Vendor_LDR"; Code[20])
        {
            Caption = 'Nº Proveedor Interno';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor"."No.";
        }
        field(50070; "web images URL_LDR"; Text[250])
        {
            Caption = 'URL Imágenes';
            DataClassification = ToBeClassified;
        }
        field(50071; "SAT email_LDR"; Text[50])
        {
            Caption = 'Email Departamento PostVenta';
            DataClassification = ToBeClassified;
        }
        field(50072; "Vendor Contract Nos._LDR"; Code[20])
        {
            Caption = 'Nº Serie Contrato Proveedor';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50073; "Contract Hour Generic Price_LDR"; Decimal)
        {
            Caption = 'Precio Hora Genérico';
            DataClassification = ToBeClassified;
        }
        field(50074; "Contract Day Generic Price_LDR"; Decimal)
        {
            Caption = 'Precio Día Genérico';
            DataClassification = ToBeClassified;
        }
        field(50075; "Contract Hour Contract Group_LDR"; Code[20])
        {
            Caption = 'Grupo Contrato por Horas';
            DataClassification = ToBeClassified;
            TableRelation = "Contract Group";
        }
        field(50076; "0 Pending Qty. on Invoicing_LDR"; Boolean)
        {
            Caption = 'Cantidad pendiente a 0 al Facturar';
            DataClassification = ToBeClassified;
        }
        field(50077; "Hide proposal Res. Allocation_LDR"; Boolean)
        {
            Caption = 'Ocultar Propuestas Asignación Recursos';
            DataClassification = ToBeClassified;
        }
        field(50078; "Hide Offered Invoice Lines_LDR"; Boolean)
        {
            Caption = 'Ocultar Líneas Factura Ofertada';
            DataClassification = ToBeClassified;
        }
        field(50079; "Automatic Delivery on Sale_LDR"; Boolean)
        {
            Caption = 'Entrega Automática en Venta';
            DataClassification = ToBeClassified;
        }
        field(50080; "Order Post not Purch. Test_LDR"; Boolean)
        {
            Caption = 'No Testear Pedidos Compra al Cerrar Pedido Servicio';
            DataClassification = ToBeClassified;
        }
        field(50081; "Automatic Cust.Item Jnl. Batch_LDR"; Code[20])
        {
            Caption = 'Sección Diario Automático Producto Cliente';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                //BatchTable: Record 7122059;
                //BatchForm: Page 7122095;
                txtItemEntry: TextConst ENU = 'ItemEntry';
                SourceCodeSetup: Record "Source Code Setup";
            begin
                SourceCodeSetup.Get();
                SourceCodeSetup.TestField(SourceCodeSetup."Item Entry Journal_LDR");

                // Clear(BatchTable);
                // BatchTable.SetRange(BatchTable."Journal Template Name", SourceCodeSetup."Item Entry Journal");

                // if BatchTable.FindSet() then;
                // BatchForm.SetTableView(BatchTable);
                // BatchForm.LookupMode := true;
                // if BatchForm.RunModal = Action::LookupOK then begin
                //     BatchForm.GetRecord(BatchTable);
                //     "Automatic Cust.Item Jnl. Batch" := BatchTable.Name;
                // end;
            end;
        }
        field(50082; "Phys. Inv. Journal Template_LDR"; Code[20])
        {
            Caption = 'Plantilla Diario Inventario Físico';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50083; "PDA Auto Post Device Entries_LDR"; Boolean)
        {
            Caption = 'Auto Registra Movimiento PDA Magazzino';
            DataClassification = ToBeClassified;
            Description = 'PDA';
        }
        field(50084; "Additional Contract Inv. Text_LDR"; Boolean)
        {
            Caption = 'Textos Adicionales Factura Contrato (Horas y Fecha Último Servicio)';
            DataClassification = ToBeClassified;
        }
        field(50085; "PDA Recl. Journal Template_LDR"; Code[20])
        {
            Caption = 'Diario Reclasificación PDA Magazzino';
            DataClassification = ToBeClassified;
            Description = 'PDA';
            TableRelation = "Item Journal Template";
        }
        field(50086; "PDA Recl. Journal Batch_LDR"; Code[20])
        {
            Caption = 'Diario Reclasificación PDA Batch';
            DataClassification = ToBeClassified;
            Description = 'PDA';
            TableRelation = "Item Journal Batch" WHERE("Journal Template Name" = FIELD("PDA Recl. Journal Template_LDR"));

            trigger OnLookup()
            var
                BatchTable: Record "Item Journal Batch";
                BatchForm: Page "Item Journal Batches";
            begin
                Clear(BatchTable);
                BatchTable.SetRange(BatchTable."Journal Template Name", "PDA Recl. Journal Template_LDR");

                if BatchTable.FindSet() then;
                BatchForm.SetTableView(BatchTable);
                BatchForm.LookupMode := true;
                if BatchForm.RunModal = Action::LookupOK then begin
                    BatchForm.GetRecord(BatchTable);
                    "PDA Recl. Journal Batch_LDR" := BatchTable.Name;
                end;
            end;
        }
        field(50087; "PDA New Items Phys. Batch_LDR"; Code[20])
        {
            Caption = 'Sección Productos Nuevos Diario Inventario PDA';
            DataClassification = ToBeClassified;
            Description = 'PDA';
            TableRelation = "Item Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("PDA New Items Phys. Template_LDR"));
        }
        field(50088; "PDA New Items Phys. Template_LDR"; Code[20])
        {
            Caption = 'Diario Productos Nuevos Diario Inventario PDA';
            DataClassification = ToBeClassified;
            Description = 'PDA';
            TableRelation = "Item Journal Template";
        }
        field(50089; "Cumulate Phys. Inv Qty._LDR"; Boolean)
        {
            Caption = 'Acumular Cantidad en Inventario Físico Dispositivo';
            DataClassification = ToBeClassified;
        }
        field(50090; "Assembly Fin. Rep. Status Code_LDR"; Code[10])
        {
            Caption = 'Estado Finalización Montaje Automático';
            DataClassification = ToBeClassified;
            TableRelation = "Repair Status";
        }
        field(50091; "Use Custom Days in Year_LDR"; Boolean)
        {
            Caption = 'Utilizar Nº de Días/Año Personalizado';
            DataClassification = ToBeClassified;
        }
        field(50092; "Copy Comments Contract Invoice_LDR"; Boolean)
        {
            Caption = 'Copiar Comentario Contrato a Factura';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50093; "Default Purpose_LDR"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Finalidad por Defecto para Productos Servicio (Alquiler a Corto,a Largo,Venta)';
            OptionCaption = ',Alquiler Corto,Alquiler Largo,Venta,Sin Finalidad';
            OptionMembers = "Short Rent","Large Rent","Sale","Without Purpose";
        }
    }
}