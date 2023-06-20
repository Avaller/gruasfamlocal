/// <summary>
/// tableextension 50098 "Posted Cartera Doc._LDR"
/// </summary>
tableextension 50098 "Posted Cartera Doc._LDR" extends "Posted Cartera Doc."
{
    fields
    {
        field(50001; "Promissory Note Printed_LDR"; BoolEAN)
        {
            Caption = 'Pagaré Impreso';
            DataClassification = ToBeClassified;
        }
        field(50002; "IOU No._LDR"; Code[20])
        {
            Caption = 'Nº Pagaré';
            DataClassification = ToBeClassified;
        }
        field(50003; "Customer Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Account No.")));
            Caption = 'Nombre Cliente';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Vendor Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Vendor"."Name" WHERE("No." = FIELD("Account No.")));
            Caption = 'Nombre Proveedor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Vendor Invoice No._LDR"; Code[35])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No." = FIELD("Document No.")));
            Caption = 'Nº Factura Proveedor';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key11; "Document No.")
        {

        }
    }
}