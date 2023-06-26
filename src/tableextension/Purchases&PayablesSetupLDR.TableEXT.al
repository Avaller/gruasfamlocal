/// <summary>
/// tableextension 50048 "Purchases & Payables Setup_LDR" 
/// </summary>
tableextension 50048 "Purchases & Payables Setup_LDR" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Forecast Nos._LDR"; Code[10])
        {
            Caption = 'Nº Serie Previsión';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Transport Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Transporte';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50002; "Warranty Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantías';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50003; "EAN Nos._LDR"; Code[20])
        {
            Caption = 'Nº Serie EAN';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Source print file_LDR"; Text[250])
        {
            Caption = 'Ejecutable de Impresión';
            DataClassification = ToBeClassified;
        }
        field(50005; "AS400 Response E-Mail_LDR"; Text[70])
        {
            Caption = 'E-Mail Respuesta AS400';
            DataClassification = ToBeClassified;
        }
        field(50006; "AS400 ftp url_LDR"; Text[70])
        {
            Caption = 'Url FTP AS400';
            DataClassification = ToBeClassified;
        }
        field(50007; "ARMOPA Dias_LDR"; Integer)
        {
            Caption = 'ARMOPA Días';
            DataClassification = ToBeClassified;
            Description = 'Parámetro para Calcular Máximos y Mínimos';
        }
        field(50008; "ARMOPA Factor_LDR"; Decimal)
        {
            Caption = 'Factor Almacén Principal';
            DataClassification = ToBeClassified;
            Description = 'Parámetro para Calcular Máximos y Mínimos';
        }
        field(50009; "ARMOPA Dias Año_LDR"; Integer)
        {
            Caption = 'ARMOPA Días Año';
            DataClassification = ToBeClassified;
            Description = 'Parámetro para Calcular Máximos y Mínimos';
        }
        field(50010; "AS400 ftp folder_LDR"; Text[70])
        {
            Caption = 'Carpeta FTP AS400';
            DataClassification = ToBeClassified;
        }
        field(50011; "AS400 ftp port_LDR"; Integer)
        {
            Caption = 'Puerto FTP AS400';
            DataClassification = ToBeClassified;
        }
        field(50012; "AS400 User_LDR"; Text[50])
        {
            Caption = 'Usuario AS400';
            DataClassification = ToBeClassified;
        }
        field(50013; "AS400 Password_LDR"; Text[50])
        {
            Caption = 'Contraseña AS400';
            DataClassification = ToBeClassified;
        }
        field(50014; "Purch. Inv. Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Factura Compra';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50015; "Purch. Credit M. Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Abono Compra';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50016; "Vendor Shipment No. Mandatory_LDR"; Boolean)
        {
            Caption = 'Nº Albarán Proveedor Obligatorio';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50017; "Payment Discount Expl. Count_LDR"; Boolean)
        {
            Caption = 'Departamento P.P. en Cuenta Explotación';
            DataClassification = ToBeClassified;
        }
        field(50018; "CIF/NIF Obligatory_LDR"; Boolean)
        {
            Caption = 'Obligatorio CIF/NIF';
            DataClassification = ToBeClassified;
        }
        field(50019; "Last File Loaded_LDR"; Text[250])
        {
            Caption = 'Último Archivo Cargado';
            DataClassification = ToBeClassified;
            Description = 'Campo Último Fichero Cargado para Máquinas y LM';
        }
        field(50020; "Last File Loaded Bis_LDR"; Text[250])
        {
            Caption = 'Último Archivo Cargado Bis';
            DataClassification = ToBeClassified;
            Description = 'Campo Último Fichero Cargado para Recambios';
        }
        field(50021; "Disp. Time Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Tiempo';
            DataClassification = ToBeClassified;
            Description = 'Horas de Desplazamiento';
            TableRelation = "Service Cost";
        }
        field(50022; "Displacement Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Desplazamientos';
            DataClassification = ToBeClassified;
            Description = 'Unidad de desplazamiento';
            TableRelation = "Service Cost";
        }
        field(50023; "Work Time Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Horas de Trabajo';
            DataClassification = ToBeClassified;
            Description = 'Horas de Trabajo';
            TableRelation = "Service Cost";
        }
        field(50024; "Materials Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Materiales';
            DataClassification = ToBeClassified;
            Description = 'Materiales';
            TableRelation = "Service Cost";
        }
        field(50025; "Armopa Dis. date formula_LDR"; DateFormula)
        {
            Caption = 'Fórmula Fecha Reparto Armopa';
            DataClassification = ToBeClassified;
        }
        field(50026; "Warranty Mgt. Type_LDR"; Option)
        {
            Caption = 'Tipo Gestión Garantías';
            DataClassification = ToBeClassified;
            OptionCaption = 'Compra,Venta';
            OptionMembers = Compra,Venta;
        }
        field(50027; "Create Payment Days_LDR"; Boolean)
        {
            Caption = 'Crear Codígo Días de Pago y de No Pago';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50028; "Armopa Search Period Formula_LDR"; DateFormula)
        {
            Caption = 'Fórmula Período Consulta Armopa';
            DataClassification = ToBeClassified;
            InitValue = '-1Y+1D';
        }
        field(50029; "ARMOPA Factor Sale_LDR"; Decimal)
        {
            Caption = 'Factor Almacén Venta';
            DataClassification = ToBeClassified;
            Description = 'Parámetro para Calcular Máximos y Mínimos';
        }
        field(50030; "ARMOPA Factor Mattress_LDR"; Decimal)
        {
            Caption = '% Factor Colchón Máximo';
            DataClassification = ToBeClassified;
            Description = 'Parámetro para Calcular Máximos y Mínimos';
        }
        field(50031; "ARMOPA Post Transfers_LDR"; Boolean)
        {
            Caption = 'Registrar Transferencias';
            DataClassification = ToBeClassified;
        }
        field(50032; "ARMOPA Order Nos._LDR"; Code[10])
        {
            Caption = 'Nº Servicio Pedido ARMOPA';
            DataClassification = ToBeClassified;
            Description = 'Serie de Pedidos de Compra ARMOPA';
            TableRelation = "No. Series";
        }
        field(50033; "Print Command_LDR"; Option)
        {
            Caption = 'Comando Impresión';
            DataClassification = ToBeClassified;
            OptionCaption = 'Comando Print,Comando Type';
            OptionMembers = print,type;
        }
        field(50034; "Company EAN Name_LDR"; Text[30])
        {
            Caption = 'Nombre Empresa EAN';
            DataClassification = ToBeClassified;
            Description = 'Nombre Concesionario para Etiquetas EAN 13 (Lariana, Faro)';
        }
        field(50035; "checkCostZero_LDR"; Boolean)
        {
            Caption = 'Aviso Coste Unitario 0 en Pedido Compra';
            DataClassification = ToBeClassified;
            Description = 'Habilita el Mostrar un Mensaje Avisando de Líneas a Coste 0 en Pedidos de Compra';
        }
        field(50036; "forzeCostUpdate_LDR"; Boolean)
        {
            Caption = 'Forzar Actualización Coste Unitario en Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Intenta Actualizar el Coste Unitario del Producto al Registrar el Albarán. Tiene Condiciones';
        }
        field(50037; "Label Type_LDR"; Option)
        {
            Caption = 'Tipo Etiquetas';
            DataClassification = ToBeClassified;
            OptionCaption = 'Intermec,Estándar 2016';
            OptionMembers = Intermec,STD;
        }
    }
}