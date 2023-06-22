/// <summary>
/// tableextension 50110 "Service Item Log_LDR"
/// </summary>
tableextension 50110 "Service Item Log_LDR" extends "Service Item Log"
{
    procedure GetDescription() Descripcion: Text[100];
    var
        ServOrder: Record "Service Header";
        ServContractHeader: Record "Service Contract Header";
    begin
        case "Document Type" of
            "Document Type"::" ":
                begin
                    Descripcion := '';
                end;
            "Document Type"::Quote:
                begin
                    if ServOrder.Get(ServOrder."Document Type"::Quote, "Document No.") then
                        Descripcion := ServOrder.Description;
                end;
            "Document Type"::Order:
                begin
                    if ServOrder.Get(ServOrder."Document Type"::Order, "Document No.") then begin
                        Descripcion := ServOrder.Description;
                    end;
                end;
            "Document Type"::Contract:
                begin
                    if ServContractHeader.Get(ServContractHeader."Contract Type"::Contract, "Document No.") then
                        Descripcion := ServContractHeader.Description;
                end;
        end;
    end;
}