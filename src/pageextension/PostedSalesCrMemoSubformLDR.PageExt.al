pageextension 50038 "PostedSalesCr.MemoSubform_LDR" extends "Posted Sales Cr. Memo Subform"
{

    /// <summary>
    /// ShowItemReturnRcptLines.
    /// </summary>
    procedure ShowItemReturnRcptLines()
    begin
        if not (Rec.Type In [Rec.Type::Item, Rec.Type::"Charge (Item)"]) then
            Rec.TestField(Type);
        ShowItemReturnRcptLines();
    end;

}