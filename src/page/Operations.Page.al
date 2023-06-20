/// <summary>
/// 
/// 
/// </summary>
page 50056 Operations
{
    Caption = 'Operations';
    PageType = List;
    SourceTable = "Operations_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Código';
                    ToolTip = 'Código';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Operation Type"; Rec."Operation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de operación';
                    ToolTip = 'Tipo de operación';
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de período';
                    ToolTip = 'Tipo de período';
                }
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                    Caption = 'Imagen';
                    ToolTip = 'Imagen';
                }
                field("Require Serv. Order"; Rec."Require Serv. Order")
                {
                    ApplicationArea = All;
                    Caption = 'Requerir orden de servidor';
                    Enabled = EnablePS;
                    ToolTip = 'Requerir orden de servidor';
                }
                field("Self/External"; Rec."Self/External")
                {
                    ApplicationArea = All;
                    Caption = 'propio / externo';
                    ToolTip = 'propio / externo';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Suboperation)
            {
                Caption = 'Suboperations';
                Image = List;

                trigger OnAction()
                var
                    Suboperation: Record Suboperation_LDR;
                    error50001: Label 'Operation is not technical or requires service request';
                    SuboperationList: Page "Suboperation List";
                begin
                    clear(Suboperation);
                    Suboperation.setRange("Operation Code", Rec.Code);
                    if (Rec."Operation Type" = Rec."Operation Type"::Technical) and (Rec."Require Serv. Order") then begin
                        SuboperationList.setTableView(Suboperation);
                        SuboperationList.LookUpMode(true);
                        SuboperationList.runModal;
                    end else
                        error(error50001);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateFields;
    end;

    trigger OnOpenPage()
    begin
        UpdateFields;
    end;

    var
        EnablePS: BoolEAN;

    local procedure UpdateFields()
    begin
        if Rec."Operation Type" = Rec."Operation Type"::Technical then
            EnablePS := true
        else
            EnablePS := false;

        CurrPage.Update(false);
    end;
}