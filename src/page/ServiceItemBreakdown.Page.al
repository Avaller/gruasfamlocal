/// <summary>
/// Page Service Item Breakdown (ID 50019).
/// </summary>
page 50019 "Service Item Breakdown"
{
    Caption = 'Service Item Breakdown';
    PageType = List;
    SourceTable = "Service Item Breakdown_LDR";

    /*
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
                field("Manufacturer Name"; Rec."Manufacturer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del Fabricante';
                    ToolTip = 'Nombre del Fabricante';
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                    Caption = 'N º de Modelo.';
                    ToolTip = 'N º de Modelo.';
                }
                field("Model Name"; Rec."Model Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del modelo';
                    ToolTip = 'Nombre del modelo';
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                    Caption = 'Por defecto';
                    ToolTip = 'Por defecto';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(View)
            {
                Caption = 'View';
                action("Show Breakdown Detail")
                {
                    Caption = 'Show Breakdown Detail';
                    Image = ProdBOMMatrixPerVersion;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Serv. Contract Inv. Group List";
                    RunPageLink = "No." = FIELD(Code), //TODO: Se cambio Code por "No." al dar el primero fallo no estar referenciado
                                  "No. Series" = FIELD("Model No."); //TODO: Se cambio "Model No." por "No. Series" al dar el primero fallo no estar referenciado

                    trigger OnAction()
                    begin
                        IF Rec.Default THEN
                            MESSAGE(Text002);
                    end;
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                action("Setup Breakdown Tree")
                {
                    Caption = 'Setup Breakdown Tree';
                    Image = Category;
                    RunObject = Page "Posted Service Item Line List";
                    RunPageLink = "Service Item No." = FIELD("Code"), //TODO: "Manufacturer Code" no esta, y lo sustitui por "Service Item No."
                                  "Service Inv. Group No." = FIELD("Model No."); //TODO: "Model Code" no esta, y lo sustitui por "Service Inv. Group No."
                }
                action("Update Breakdown Detail")
                {
                    Caption = 'Update Breakdown Detail';
                    Image = CopyBOM;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        CopyServItemBreakdown: Report 50002;
                    begin

                        IF NOT CONFIRM(Text001, FALSE) THEN
                            ERROR('');

                        CLEAR(CopyServItemBreakdown);

                        CopyServItemBreakdown.SetValues(FALSE, Rec.Code, Rec."Model No.");
                        CopyServItemBreakdown.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Updating an existing Breakdown, wili append all detail from Source''s Breakdown into the selected one. Are you sure you want to proceed?';
        Text002: Label 'You are about to modify the Default Breakdown Detail. Please, proceed carefully';
    */
}