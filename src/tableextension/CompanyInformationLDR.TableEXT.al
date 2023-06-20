/// <summary>
/// tableextension 50013 "Company Information_LDR"
/// </summary>
tableextension 50013 "Company Information_LDR" extends "Company Information"
{
    fields
    {
        field(50000; "Export Ingestrel_LDR"; BoolEAN)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50001; "Company ID_LDR"; Code[2])
        {
            Caption = 'ID Empresa ';
            DataClassification = ToBeClassified;
        }
        field(50002; "Manager Name_LDR"; Text[50])
        {
            Caption = 'Nombre Gerente';
            DataClassification = ToBeClassified;
        }
        field(50003; "Risks Name_LDR"; Text[50])
        {
            Caption = 'Nombre Riesgos';
            DataClassification = ToBeClassified;
        }
        field(50004; "Risks Cif_LDR"; Text[20])
        {
            Caption = 'Cif Riesgos';
            DataClassification = ToBeClassified;
        }
        field(50005; "Committee Name_LDR"; Text[50])
        {
            Caption = 'Nombre Comité';
            DataClassification = ToBeClassified;
        }
        field(50006; "Committee Cif_LDR"; Text[20])
        {
            Caption = 'Cif Comité';
            DataClassification = ToBeClassified;
        }
        field(50007; "Signature Manager_LDR"; Text[100])
        {
            Caption = 'Firma Gerente';
            DataClassification = ToBeClassified;
        }
        field(50008; "Signature Risks_LDR"; Text[100])
        {
            Caption = 'Firma Riesgos';
            DataClassification = ToBeClassified;
        }
        field(50009; "Signature Committe_LDR"; Text[100])
        {
            Caption = 'Firma de Comite';
            DataClassification = ToBeClassified;
        }
        field(50010; Colour_LDR; Code[20])
        {
            Caption = 'Color';
            DataClassification = ToBeClassified;
        }
        field(50011; "Export Date_LDR"; Date)
        {
            Caption = 'Fecha Exportación';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; Logo_LDR; Text[100])
        {
            Caption = 'Logo';
            DataClassification = ToBeClassified;
        }
        field(50013; "Manager Cif_LDR"; Text[20])
        {
            Caption = 'Cif Gerente';
            DataClassification = ToBeClassified;
        }
        field(50014; "Company Registry Text_LDR"; Text[200])
        {
            Caption = 'Texto Registro Mercantil';
            DataClassification = ToBeClassified;
        }
        field(50015; "Footer Picture_LDR"; Blob)
        {
            Caption = 'Imagen Pie de Página';
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50016; "Distributor Short Name_LDR"; Text[30])
        {
            Caption = 'Nombre Concesionario Abreviado';
            DataClassification = ToBeClassified;
        }
    }
}