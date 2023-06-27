/// <summary>
/// Page Services Item Refills Reg (ID 50021).
/// </summary>
page 50021 "Services Item Refills Reg"
{
    Caption = 'Services Item Refills Reg';
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Service Item Refills Reg_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ProcessLDR"; Rec.Process)
                {
                    ApplicationArea = All;
                    Caption = 'Proceso';
                    ToolTip = 'Proceso';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    Caption = 'tipo de transacción';
                    ToolTip = 'tipo de transacción';
                    Visible = false;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de transacción';
                    ToolTip = 'Codigo de transacción';
                }
                field("Terminal Code"; Rec."Terminal Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de terminal';
                    ToolTip = 'Código de terminal';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Transacción';
                    ToolTip = 'Fecha de Transacción';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de transacción';
                    ToolTip = 'Tiempo de transacción';
                }
                field("Refill Type I/E"; Rec."Refill Type I/E")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de recarga I/E';
                    ToolTip = 'Tipo de recarga I/E';
                }
                field(Distributed; Rec.Distributed)
                {
                    ApplicationArea = All;
                    Caption = 'Repartido';
                    ToolTip = 'Repartido';
                }
                field("Distribution Refill"; Rec."Distribution Refill")
                {
                    ApplicationArea = All;
                    Caption = 'Recarga de Distribución';
                    ToolTip = 'Recarga de Distribución';
                }
                field("Refill Type"; Rec."Refill Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de recarga';
                    ToolTip = 'Tipo de recarga';
                    Visible = false;
                }
                field("Vehicle No"; Rec."Vehicle No")
                {
                    ApplicationArea = All;
                    Caption = 'No vehiculo';
                    ToolTip = 'No vehiculo';
                }
                field("Service Item Code"; Rec."Service Item Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de artículo de servicio';
                    ToolTip = 'Código de artículo de servicio';
                }
                field("Serv. Item Counter No."; Rec."Serv. Item Counter No.")
                {
                    ApplicationArea = All;
                    Caption = 'Servicio Nº de contador de artículos';
                    ToolTip = 'Servicio Nº de contador de artículos';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    Caption = 'Conductor No.';
                    ToolTip = 'Conductor No.';
                }
                field("Cont Type"; Rec."Cont Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo continuo';
                    ToolTip = 'Tipo continuo';
                    Visible = false;
                }
                field("Before Value"; Rec."Before Value")
                {
                    ApplicationArea = All;
                    Caption = 'Antes del valor';
                    ToolTip = 'Antes del valor';
                }
                field("Actual Value"; Rec."Actual Value")
                {
                    ApplicationArea = All;
                    Caption = 'Valor actual';
                    ToolTip = 'Valor actual';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de artículo';
                    ToolTip = 'Tipo de artículo';
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de proveedor';
                    Editable = false;
                    ToolTip = 'Número de proveedor';
                }
                field("Transaction Volume"; Rec."Transaction Volume")
                {
                    ApplicationArea = All;
                    Caption = 'Volumen de transacciones';
                    Editable = false;
                    ToolTip = 'Volumen de transacciones';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio unitario';
                    Editable = false;
                    ToolTip = 'Precio unitario';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad';
                    Editable = false;
                    ToolTip = 'Cantidad';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ToolTip = 'No';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Process)
            {
                Caption = 'Process';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ServItemRefillMgt: Codeunit EventosTablas_LDR;
                begin
                    //MESSAGE('Pendiente de Implementar');

                    ServItemRefillMgt.ProcessSingleEntry(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
    }
}