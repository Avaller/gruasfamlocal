/// <summary>
/// tableextension 50112 "Service Price Group_LDR"
/// </summary>
tableextension 50112 "Service Price Group_LDR" extends "Service Price Group"
{
    trigger OnAfterDelete()
    var
    //ServPriceItemPrices: Record 7122009;
    begin
        // ServPriceItemPrices.SetRange(ServPriceItemPrices."Service Price Group", Code);
        // if ServPriceItemPrices.FindSet() then
        //     ServPriceItemPrices.DeleteAll();
    end;
}