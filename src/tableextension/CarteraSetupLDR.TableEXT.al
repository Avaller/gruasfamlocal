/// <summary>
/// tableextension 50101 "Cartera Setup_LDR"
/// </summary>
tableextension 50101 "Cartera Setup_LDR" extends "Cartera Setup"
{
    fields
    {
        field(50000; "Excel Import Path_LDR"; Text[250])
        {
            Caption = 'Ruta Importación Excel';
            DataClassification = ToBeClassified;
        }
        field(50001; "Excel Sheet Name_LDR"; Text[100])
        {
            Caption = 'Nombre de la Hoja Excel';
            DataClassification = ToBeClassified;
        }
        field(50002; "Expenses Application Account_LDR"; Code[10])
        {
            Caption = 'Cuenta Cargos VISA';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50003; "VISA Description_LDR"; Text[50])
        {
            Caption = 'Descripción de Gastos';
            DataClassification = ToBeClassified;
        }
        field(50004; "VISA Journal Name_LDR"; Code[10])
        {
            Caption = 'Nombre Diario VISA';
            DataClassification = ToBeClassified;
        }
        field(50005; "Liquidation Journal Name_LDR"; Code[10])
        {
            Caption = 'Nombre Diario Liquidación';
            DataClassification = ToBeClassified;
        }
        field(50006; "File SEPA Bankia_LDR"; BoolEAN)
        {
            Caption = 'Fichero SEPA Bankia';
            DataClassification = ToBeClassified;
        }
    }
}