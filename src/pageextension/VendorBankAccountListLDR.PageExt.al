/// <summary>
/// PageExtension VendorBankAccountList_LDR (ID 50076) extends Record Vendor Bank Account List.
/// </summary>
pageextension 50076 "VendorBankAccountList_LDR" extends "Vendor Bank Account List"
{
    layout
    {
        addafter("Post Code")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Caption = 'Número de proveedor';
                Editable = false;
                ToolTip = 'Número de proveedor';
            }
        }
    }
}