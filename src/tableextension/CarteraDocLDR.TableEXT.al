/// <summary>
/// tableextension 50097 "Cartera Doc._LDR"
/// </summary>
tableextension 50097 "Cartera Doc._LDR" extends "Cartera Doc."
{
    fields
    {
        field(50000; "Receipt Date_LDR"; Date)
        {
            Caption = 'Fecha Recepción';
            DataClassification = ToBeClassified;
        }
        field(50001; "Customer Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Account No.")));
            Caption = 'Nombre Cliente';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Vendor Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Vendor"."Name" WHERE("No." = FIELD("Account No.")));
            Caption = 'Nombre Proveedor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Vendor Invoice No._LDR"; Code[20]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No." = FIELD("Document No.")));
            Caption = 'Nº Factura Proveedor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "IOU No._LDR"; Code[20])
        {
            Caption = 'Nº Pagaré';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PaymentMethod: Record "Payment Method";
            begin
                Clear(PaymentMethod);
                PaymentMethod.Get("Payment Method Code");
                if PaymentMethod."Bill Type" <> PaymentMethod."Bill Type"::IOU then
                    Error(txterror001);
            end;
        }
        field(50005; "IOU Printed_LDR"; Boolean)
        {
            Caption = 'Pagaré Impreso';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key14; "No.", "Type", "Account No.", "Due Date")
        {
            SumIndexFields = "Remaining Amount", "Remaining Amt. (LCY)";
        }
        key(Key15; "Document No.")
        {

        }
    }

    var
        txterror001: TextConst ENU = 'The Payment Method must be a Payment Method with a Bill Type IOU', ESP = 'La Forma de Pago tiene que ser una Forma de Pago que el tipo de efecto sea Pagar';
}