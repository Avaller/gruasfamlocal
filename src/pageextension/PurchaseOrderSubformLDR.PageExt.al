/// <summary>
/// PageExtension Purchase Order Subform_LDR (ID 50023) extends Record Purchase Order Subform.
/// </summary>
pageextension 50023 "Purchase Order Subform_LDR" extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2_LDR"; Rec."No. 2_LDR")
            {
                ApplicationArea = All;
                Caption = 'No';
                ToolTip = 'No';
            }
            field("Vendor Item No."; Rec."Vendor Item No.")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo del proveedor';
                Editable = false;
                ToolTip = 'Número de artículo del proveedor';
            }
        }
        addafter("IC Partner Reference")
        {
            field("Gen. Bus. Posting Group_LDR"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de contabilización comercial general';
                ToolTip = 'Grupo de contabilización comercial general';
            }
            field("VAT Bus. Posting Group_LDR"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de registro comercial de IVA';
                ToolTip = 'Grupo de registro comercial de IVA';
            }
        }
        addafter("Variant Code")
        {
            field("No. EAN Labels_LDR"; Rec."No. EAN Labels_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nº Etiquetas EAN';
                ToolTip = 'Nº Etiquetas EAN';
            }
        }
        addafter(Nonstock)
        {
            field("Gen. Prod. Posting Group_LDR"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Prod. gen. Grupo de contabilización';
                ToolTip = 'Prod. gen. Grupo de contabilización';
                Visible = false;
            }
        }
        addafter(Description)
        {
            field("Description 2_LDR"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
            field(Notas1_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas';
                ToolTip = 'Notas';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                Caption = 'Centro de Responsabilidad';
                Editable = false;
                ToolTip = 'Centro de Responsabilidad';
                Visible = false;
            }
        }
        addafter("Bin Code")
        {
            field("Demand Location Code_LDR"; Rec."Demand Location Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de ubicación de la demanda';
                ToolTip = 'Código de ubicación de la demanda';
            }
            field("Demand Bin Code_LDR"; Rec."Demand Bin Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de ubicación de demanda';
                ToolTip = 'Código de ubicación de demanda';
            }
        }
        addafter("Line Amount")
        {
            field("Service Order No._LDR"; Rec."Service Order No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de orden de servicio';
                ToolTip = 'Número de orden de servicio';
            }
            field("Service Item Line No._LDR"; Rec."Service Item Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de línea de artículo de servicio';
                ToolTip = 'Número de línea de artículo de servicio';
            }
        }
        addafter("Lead Time Calculation")
        {
            field("Service Item No._LDR"; Rec."Service Item No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo de servicio';
                ToolTip = 'Número de artículo de servicio';
            }
        }
    }

    actions
    {
        addafter(OrderTracking)
        {
            action(BinContents)
            {
                ApplicationArea = All;
                Caption = 'Contenidos ubicación';
                Image = BinContent;

                trigger OnAction()
                var
                    PageItemBinContents: Page "Bin Content";
                    BinContent: Record "Bin Content";
                begin
                    Rec.TestField(Type, Rec.Type::Item);
                    BinContent.SetRange("Item No.", Rec."No.");
                    PageItemBinContents.SetTableView(BinContent);
                    PageItemBinContents.RunModal();
                end;
            }
            action("Stockkeepinig Units")
            {
                ApplicationArea = All;
                Caption = 'Uds. de almace&nam.';
                Image = SKU;

                trigger OnAction()
                var
                    StockkeepingUnit: Record "Stockkeeping Unit";
                    StockkeepingUnitList: Page "Stockkeeping Unit List";
                begin
                    Rec.TestField(Type, Rec.Type::Item);
                    StockkeepingUnit.SetRange("Item No.", Rec."No.");
                    StockkeepingUnitList.SetTableView(StockkeepingUnit);
                    StockkeepingUnitList.RunModal();
                end;
            }
        }
    }

    var
        txtEsMaquina: Label 'Se trata de una compra de maquina ?';
}