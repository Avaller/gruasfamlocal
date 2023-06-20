/// <summary>
/// tableextension 50045 "VAT Amount Line_LDR"
/// </summary>
tableextension 50045 "VAT Amount Line_LDR" extends "VAT Amount Line"
{
    fields
    {
        field(50000; "Tax Withholding Amount_LDR"; Decimal)
        {
            Caption = 'Importe Retención';
            DataClassification = ToBeClassified;
        }
        field(50001; "VAT Text_LDR"; Text[20])
        {
            Caption = 'Nombre Impuesto';
            DataClassification = ToBeClassified;
        }
    }
    procedure VATAmountText2(): Text[30];
    begin
        if Find('-') then
            if Next() = 0 then
                if "VAT %" <> 0 then
                    exit(Text50001);
        exit(text50002);
    end;

    procedure CopyFrom(FromVATAmountLine: Record "VAT Amount Line")
    begin
        DeleteAll();
        if FromVATAmountLine.Find('-') then
            repeat
                Rec := FromVATAmountLine;
                Insert();
            until FromVATAmountLine.Next() = 0;
    end;

    var
        Text50001: TextConst ENU = 'VAT Amount', ESP = 'Importe Impuesto';
        Text50002: TextConst ENU = 'VAT+EC Amount', ESP = 'Importe Impuesto+RE';
}