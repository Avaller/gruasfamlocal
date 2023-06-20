/// <summary>
/// tableextension 50041 "Source Code Setup_LDR"
/// </summary>
tableextension 50041 "Source Code Setup_LDR" extends "Source Code Setup"
{
    fields
    {
        field(50000; "Service Journal_LDR"; Code[10])
        {
            Caption = 'Diario Servicios';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50001; "Service Contract Line_LDR"; Code[10])
        {
            Caption = 'Línea Contrato Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50002; "Fixed Asset_LDR"; Code[10])
        {
            Caption = 'Activo Fijo';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50003; Leasing_LDR; Code[10])
        {
            Caption = 'Leasing';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50004; "Internal Contract Line_LDR"; Code[10])
        {
            Caption = 'Línea Contrato Interno';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50005; "Internal Contract Header_LDR"; Code[10])
        {
            Caption = 'Cabecera Contrato Interno';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50006; "Service Item Reval Journal_LDR"; Code[10])
        {
            Caption = 'Línea Contrato Proveedor';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50007; "Service Item Entry Journal_LDR"; Code[10])
        {
            Caption = 'Diario Movimientos Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50008; "Item Entry Journal_LDR"; Code[10])
        {
            Caption = 'Diario Movimiento Producto';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50009; "Vendor Contract Line_LDR"; Code[10])
        {
            Caption = 'Línea Contrato Proveedor';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50010; "Vendor Contract Header_LDR"; Code[10])
        {
            Caption = 'Cabecera Contrato Proveedor';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
    }
}