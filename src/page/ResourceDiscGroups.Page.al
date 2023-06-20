/// <summary>
/// Page Resource Disc. Groups (ID 50037).
/// </summary>
page 50037 "Resource Disc. Groups"
{
    Caption = 'Resource Disc. Groups';
    PageType = List;
    SourceTable = "Resource DisCount Group_LDR";

    layout
    {
        area(content)
        {
            repeater(Contenido)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    ToolTip = 'Codigo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Resource &Disc. Groups")
            {
                Caption = 'Resource &Disc. Groups';
                action("Sales &Line DisCounts")
                {
                    Caption = 'Sales &Line DisCounts';
                    Image = SalesLineDisc;
                    RunObject = Page "Sales Line DisCounts";
                    RunPageLink = Type = Const("Item Disc. Group"), //TODO: Ponia "Resource Disc. Group", pero daba error
                                  Code = field(Code);
                    RunPageView = Sorting(Type, Code);
                }
            }
        }
    }

    /// <summary>
    /// GetSelectionFilter.
    /// </summary>
    /// <returns>Return value of type Code[80].</returns>
    procedure GetSelectionFilter(): Code[80]
    var
        ItemDiscGr: Record "Item DisCount Group";
        FirstItemDiscGr: Code[30];
        LastItemDiscGr: Code[30];
        SelectionFilter: Code[250];
        ItemDiscGrCount: Integer;
        More: BoolEAN;
    begin
        CurrPage.SETSELECTIONFILTER(ItemDiscGr);
        ItemDiscGrCount := ItemDiscGr.Count;
        if ItemDiscGrCount > 0 then begin
            ItemDiscGr.find('-');
            while ItemDiscGrCount > 0 do begin
                ItemDiscGrCount := ItemDiscGrCount - 1;
                ItemDiscGr.markedOnly(false);
                FirstItemDiscGr := ItemDiscGr.Code;
                LastItemDiscGr := FirstItemDiscGr;
                More := (ItemDiscGrCount > 0);
                while More do
                    if ItemDiscGr.Next = 0 then
                        More := false
                    else
                        if NOT ItemDiscGr.mark then
                            More := false
                        else begin
                            LastItemDiscGr := ItemDiscGr.Code;
                            ItemDiscGrCount := ItemDiscGrCount - 1;
                            if ItemDiscGrCount = 0 then
                                More := false;
                        end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstItemDiscGr = LastItemDiscGr then
                    SelectionFilter := SelectionFilter + FirstItemDiscGr
                else
                    SelectionFilter := SelectionFilter + FirstItemDiscGr + '..' + LastItemDiscGr;
                if ItemDiscGrCount > 0 then begin
                    ItemDiscGr.markedOnly(true);
                    ItemDiscGr.Next;
                end;
            end;
        end;
        exit(SelectionFilter);
    end;
}