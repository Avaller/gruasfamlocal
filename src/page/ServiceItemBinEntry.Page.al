/// <summary>
/// Page Service Item Bin Entry (ID 50034).
/// </summary>
page 50034 "Service Item Bin Entry"
{
    // UPG2016 23/12/2015 1CF_RPB Dimension functionality reimplemented

    Caption = 'Service Item Bin Entry';
    PageType = List;
    SourceTable = "Posted Serv Item Bin Entr_LDR";

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de entrada';
                    ToolTip = 'Número de entrada';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de entrada';
                    ToolTip = 'Tipo de entrada';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de publicación';
                    ToolTip = 'Fecha de publicación';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Documento No.';
                    ToolTip = 'Documento No.';
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de artículo de servicio';
                    ToolTip = 'Número de artículo de servicio';
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Documento fuente No.';
                    ToolTip = 'Documento fuente No.';
                }
                field("Service Item Model"; Rec."Service Item Model")
                {
                    ApplicationArea = All;
                    Caption = 'Modelo de artículo de servicio';
                    ToolTip = 'Modelo de artículo de servicio';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. de serie';
                    ToolTip = 'No. de serie';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Own; Rec.Own)
                {
                    ApplicationArea = All;
                    Caption = 'Propio';
                    ToolTip = 'Propio';
                }
                field("Originally Customer"; Rec."Originally Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Cliente original';
                    ToolTip = 'Cliente original';
                }
                field("Originally Name"; Rec."Originally Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre original';
                    ToolTip = 'Nombre original';
                }
                field("Originally Cust Ship Address"; Rec."Originally Cust Ship Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío del cliente original';
                    ToolTip = 'Dirección de envío del cliente original';
                }
                field("Originally Ship-to Address"; Rec."Originally Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío original';
                    Editable = false;
                    ToolTip = 'Dirección de envío original';
                }
                field("Originally Ship-to Address 2"; Rec."Originally Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío original 2';
                    Editable = false;
                    ToolTip = 'Dirección de envío original 2';
                }
                field("Originally Ship-to Post Code"; Rec."Originally Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código postal de envío original';
                    Editable = false;
                    ToolTip = 'Código postal de envío original';
                }
                field("Originally Ship-to City"; Rec."Originally Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad de destino original';
                    Editable = false;
                    ToolTip = 'Ciudad de destino original';
                }
                field("Assignment Customer"; Rec."Assignment Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Cliente de asignación';
                    ToolTip = 'Cliente de asignación';
                }
                field("Assignment Name"; Rec."Assignment Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de la asignación';
                    ToolTip = 'Nombre de la asignación';
                }
                field("Assignment Cust Ship Address"; Rec."Assignment Cust Ship Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío del cliente de asignación';
                    ToolTip = 'Dirección de envío del cliente de asignación';
                }
                field("Assignment Ship-to Address"; Rec."Assignment Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío de la asignación';
                    Editable = false;
                    ToolTip = 'Dirección de envío de la asignación';
                }
                field("Assignment Ship-to Address 2"; Rec."Assignment Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío de asignación 2';
                    Editable = false;
                    ToolTip = 'Dirección de envío de asignación 2';
                }
                field("Assignment Ship-to Post Code"; Rec."Assignment Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código postal de destino de la asignación';
                    Editable = false;
                    ToolTip = 'Código postal de destino de la asignación';
                }
                field("Assignment Ship-to City"; Rec."Assignment Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad de destino de la asignación';
                    Editable = false;
                    ToolTip = 'Ciudad de destino de la asignación';
                }
                field(Printed; Rec.Printed)
                {
                    ApplicationArea = All;
                    Caption = 'Impreso';
                    ToolTip = 'Impreso';
                }
                field("CMR Necessary"; Rec."CMR Necessary")
                {
                    ApplicationArea = All;
                    Caption = 'CMR necesario';
                    ToolTip = 'CMR necesario';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Caption = 'Al corriente';
                    ToolTip = 'Al corriente';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Caption = 'Centro de responsabilidad';
                    ToolTip = 'Centro de responsabilidad';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    Caption = 'Identificación de usuario';
                    ToolTip = 'Identificación de usuario';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dimensión global 1';
                    ToolTip = 'Código de dimensión global 1';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de agente de envío';
                    ToolTip = 'Código de agente de envío';
                }
                field("No. of hours"; Rec."No. of hours")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de horas';
                    ToolTip = 'Nº de horas';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de Dimensión Global 2';
                    ToolTip = 'Código de Dimensión Global 2';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Entry")
            {
                Caption = '&Entry';
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        text00: Label 'The Service Item: purchase Entry does not generate a document';
                        recLineaDiariohis: Record "Posted Serv Item Bin Entr_LDR";
                    begin
                        //Comprobar si es compra no genera el word

                        IF Rec."Entry Type" = Rec."Entry Type"::Purchase THEN BEGIN
                            MESSAGE(text00)
                        END ELSE BEGIN
                            recLineaDiariohis.COPY(Rec);
                            recLineaDiariohis.SETRECFILTER;
                            REPORT.RUN(50032, TRUE, FALSE, recLineaDiariohis);
                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }
}