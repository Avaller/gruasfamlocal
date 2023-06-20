/// <summary>
/// Page Service Item Counter (ID 50011).
/// </summary>
page 50011 "Service Item Counter"
{
    Caption = 'Service Item Counter';
    PageType = List;
    SourceTable = "Service Item Counter_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    Editable = false;
                    ToolTip = 'Codigo';
                    Visible = false;
                }
                field("Counter No."; Rec."Counter No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de contador';
                    ToolTip = 'Número de contador';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("KM/H Buy"; Rec."KM/H Buy")
                {
                    ApplicationArea = All;
                    Caption = 'KM/H Comprar';
                    ToolTip = 'KM/H Comprar';
                }
                field("KM/H Start"; Rec."KM/H Start")
                {
                    ApplicationArea = All;
                    Caption = 'KM/H Inicio';
                    ToolTip = 'KM/H Inicio';
                }
                field("KM/H Actual"; Rec."KM/H Actual")
                {
                    ApplicationArea = All;
                    Caption = 'KM/H reales';
                    ToolTip = 'KM/H reales';
                }
                field("KM/H Accumulated"; Rec."KM/H Accumulated")
                {
                    ApplicationArea = All;
                    Caption = 'KM/H acumulados';
                    ToolTip = 'KM/H acumulados';
                }
                field("KM/H Effective"; Rec."KM/H Effective")
                {
                    ApplicationArea = All;
                    Caption = 'KM / H efectivo';
                    ToolTip = 'KM / H efectivo';
                }
                field("Terminal Code"; Rec."Terminal Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de terminal';
                    ToolTip = 'Código de terminal';
                }
                field("Average Consumption"; Rec."Average Consumption")
                {
                    ApplicationArea = All;
                    Caption = 'Consumo medio';
                    ToolTip = 'Consumo medio';
                }
                field("Unit Measure"; Rec."Unit Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Unidad de medida';
                    ToolTip = 'Unidad de medida';
                }
                field("Consumption Type"; Rec."Consumption Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de consumo';
                    ToolTip = 'Tipo de consumo';
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de modificación';
                    ToolTip = 'Fecha de modificación';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ServItemCounterNo)
            {
                RunObject = Page "Services Item Refills Reg";
                //RunPageLink = "Serv. Item Counter No." = field(Code); //TODO: No puede convertir Integer a Code
            }
        }
    }
}