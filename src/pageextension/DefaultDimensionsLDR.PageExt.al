pageextension 50085 "Default Dimensions" extends "Default Dimensions"
{
    layout
    {
        addafter("Dimension Code")
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Caption = '';
                ToolTip = '';
            }
        }
    }

    trigger OnOpenPage()
    begin
        DimCodeEditable := true;
        DimValueCodeEditable := true;
        ValuePostingEditable := true;
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Table ID" = 7122030 THEN BEGIN
            DimCodeEditable := FALSE;
            DimValueCodeEditable := FALSE;
            ValuePostingEditable := FALSE;
        END ELSE BEGIN
            DimCodeEditable := TRUE;
            DimValueCodeEditable := TRUE;
            ValuePostingEditable := TRUE;
        END;
    end;

    var
        [InDataSet]
        DimCodeEditable: Boolean;
        [InDataSet]
        DimValueCodeEditable: Boolean;
        [InDataSet]
        ValuePostingEditable: Boolean;
}