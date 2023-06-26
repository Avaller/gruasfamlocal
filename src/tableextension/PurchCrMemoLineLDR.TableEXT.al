/// <summary>
/// tableextension 50029 "Purch. Cr. Memo Line_LDR"
/// </summary>
tableextension 50029 "Purch. Cr. Memo Line_LDR" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; Warranty_LDR; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
        field(50001; "Service Item No._LDR"; Code[20])
        {
            Caption = 'Nº Producto Servicio';
            DataClassification = ToBeClassified;
            Description = 'Nº Producto Servicio';
            Editable = false;
            TableRelation = "Service Item";
        }
        field(50002; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50003; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50004; "Service Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Servicio';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));

            trigger OnLookup()
            var
                ServContractHeader: Record "Service Contract Header";
            begin
                ServContractHeader.FilterGroup(2);
                ServContractHeader.SetRange(ServContractHeader."Contract Type", ServContractHeader."Contract Type"::Contract);
                ServContractHeader.FilterGroup(0);
                if Page.RunModal(0, ServContractHeader) = Action::LookupOK then
                    Validate("Service Contract No._LDR", ServContractHeader."Contract No.");
            end;
        }
        field(50005; "Vendor Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Proveedor';
            DataClassification = ToBeClassified;
            //TableRelation = Table70072.Field1 WHERE (Field2=CONST(1)); 
        }
        field(50006; "Service Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato Servicio';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                ServContractHeader: Record "Service Contract Header";
            begin
                ServContractHeader.FilterGroup(2);
                ServContractHeader.SetRange(ServContractHeader."Contract Type", ServContractHeader."Contract Type"::Contract);
                ServContractHeader.FilterGroup(0);
                if Page.RunModal(0, ServContractHeader) = Action::LookupOK then
                    Validate("Service Contract No._LDR", ServContractHeader."Contract No.");
            end;
        }
        field(50007; "Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}