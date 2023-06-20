/// <summary>
/// tableextension 50008 "Sales Header_LDR"
/// </summary>
tableextension 50008 "Sales Header_LDR" extends "Sales Header"
{
    fields
    {
        field(50000; "Sales Order Series No."; Code[20])
        {
            Caption = 'Nº Serie Pedido Venta';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
                if "Sales Order Series No." <> '' then begin
                    SalesSetup.Get();
                    SalesSetup.TestField("Order Nos.");
                    NoSeriesMgt.TestSeries(SalesSetup."Order Nos.", "Sales Order Series No.");
                end;
                TestField("Sales Order Series No.");
            end;

            trigger OnLookup()
            var
                ServiceHeader: Record "Service Header";
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
                with SalesHeader do begin
                    SalesHeader := Rec;
                    SalesSetup.Get();
                    SalesSetup.TestField(SalesSetup."Order Nos.");
                    if NoSeriesMgt.LookupSeries(SalesSetup."Order Nos.", "Sales Order Series No.") then
                        Validate("Sales Order Series No.");
                    Rec := SalesHeader;
                end;
            end;
        }
        field(50001; "Send Document By Mail"; BoolEAN)
        {
            Caption = 'Enviar Documento por Mail';
            DataClassification = ToBeClassified;
        }
        field(50002; "E-Mail Destination"; Text[250])
        {
            Caption = 'E-Mail de destino';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
    }

    var
        Text3: TextConst ENU = 'It is not possible to close %1 because it is included on bill group.', ESP = '%1 No se puede liquidar ya que esta incluido en una remesa.';
        Text4: TextConst ENU = 'Delete it from bill group and try.', ESP = 'Borrelo de la remesa e intentelo de nuevo.';

    procedure CheckBillSituation();
    var
        Doc: Record "Cartera Doc.";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry2.SetCurrentKey("Document No.", "Document Type", "Customer No.");
        CustLedgerEntry2.SetRange("Document No.", "Applies-to Doc. No.");
        CustLedgerEntry2.SetRange("Bill No.", "Applies-to Bill No.");
        CustLedgerEntry2.SetFilter("Document Status", '<>%1', CustLedgerEntry2."Document Status"::" ");
        if CustLedgerEntry2.Find('-') then begin
            CustLedgerEntry2.TestField("Document Status", CustLedgerEntry2."Document Status"::Open);
            if Doc.Get(Doc.Type::Receivable, CustLedgerEntry2."Entry No.") then
                if Doc."Bill Gr./Pmt. Order No." <> '' then
                    Error(
                      Text3 +
                      Text4,
                      CustLedgerEntry2.Description);
        end;
    end;
}