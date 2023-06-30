/// <summary>
/// PageExtension Resource Groups_LDR (ID 50026) extends Record Resource Groups.
/// </summary>
pageextension 50026 "Resource Groups_LDR" extends "Resource Groups"
{
    layout
    {
        addafter(Name)
        {
            field("Base Calendar Code_LDR"; Rec."Base Calendar Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código base del calendario';
                ToolTip = 'Código base del calendario';
            }
        }
    }

    PROCEDURE GetSelectionFilter(): Code[80];
    VAR
        ResourceGroup: Record "Resource Group";
        FirstItem: Code[30];
        LastItem: Code[30];
        SelectionFilter: Code[250];
        ItemCount: Integer;
        More: Boolean;
    BEGIN
        // Obtiene los elementos seleccionados
        CurrPage.SetSelectionFilter(ResourceGroup);
        ItemCount := ResourceGroup.COUNT;
        if ItemCount > 0 then begin
            ResourceGroup.find('-');
            while ItemCount > 0 do begin
                ItemCount := ItemCount - 1;
                ResourceGroup.MarkedOnly(false);
                FirstItem := ResourceGroup."No.";
                LastItem := FirstItem;
                More := (ItemCount > 0);
                while More do
                    if ResourceGroup.Next() = 0 then
                        More := false
                    else
                        if not ResourceGroup.Mark() then
                            More := false
                        else Begin
                            LastItem := ResourceGroup."No.";
                            ItemCount := ItemCount - 1;
                            if ItemCount = 0 then
                                More := false;
                        end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstItem = LastItem then
                    SelectionFilter := SelectionFilter + FirstItem
                else
                    SelectionFilter := SelectionFilter + FirstItem + '..' + LastItem;
                if ItemCount > 0 then begin
                    ResourceGroup.MarkedOnly(true);
                    ResourceGroup.Next();
                end;
            end;
        end;
        exit(SelectionFilter);
    end;
}