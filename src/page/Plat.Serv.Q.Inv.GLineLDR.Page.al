/// <summary>
/// Page Plat. Serv. Q. Inv. G Line (ID 50105).
/// </summary>
page 50105 "Plat. Serv. Q. Inv. G Line"
{
    // version FAM

    AutoSplitKey = true;
    Caption = 'Linea de Operacion de Oferta Servicio Plataforma - Grupo Facturación';
    CardPageID = "Crane Serv. Q. Op. Inv. G Card";
    PageType = ListPart;
    SourceTable = "Platf. Serv. Q. Inv G Line_LDR";
    SourceTableView = Sorting("Quote No.", "Line No.");


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice Group No."; Rec."Invoice Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de grupo de facturas';
                    ToolTip = 'Número de grupo de facturas';
                }
                field("Invoice Group Description"; Rec."Invoice Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción del grupo de facturas';
                    ToolTip = 'Descripción del grupo de facturas';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. de tarifa';
                    ToolTip = 'No. de tarifa';

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
                        ServiceItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
                        ServiceItemRateLinePlatf: Record "Servic Item Rat Lin - Plat_LDR";
                        pageServItemRateCrane: Page "Service Item Prices_LDR";
                        pageServItemRatePlatf: Page "Serv. Item Bin Ent. Jour Temp.";
                    begin
                        Rec.TestField(Rec."Invoice Group No.");
                        ServiceItemInvoiceGroup.Get(Rec."Invoice Group No.");

                        ServiceItemRateLinePlatf.reset;
                        ServiceItemRateLinePlatf.filtergroup(2);
                        ServiceItemRateLinePlatf.setRange("Invoice Group No.", Rec."Invoice Group No.");
                        ServiceItemRateLinePlatf.setRange("Header Status", ServiceItemRateLineCrane."Header Status"::Locked);
                        ServiceItemRateLinePlatf.filtergroup(0);
                        //ServiceItemRateLineCrane.setFilter("Header Valid Start Date",'..%1',WORKDATE);
                        ServiceItemRateLinePlatf.setFilter("Header Valid end Date", '%1..', WORKDATE);
                        Clear(pageServItemRatePlatf);
                        pageServItemRatePlatf.SetTableView(ServiceItemRateLinePlatf);
                        pageServItemRatePlatf.LookUpMode(true);
                        if pageServItemRatePlatf.runModal = ACTION::LookupOK then begin
                            pageServItemRatePlatf.GetRECORD(ServiceItemRateLinePlatf);
                            Rec.VALIDATE(Rec."Rate No.", ServiceItemRateLinePlatf.Code);
                        end;
                    end;
                }
                field("Rate Description"; Rec."Rate Description")
                {
                    ApplicationArea = All;
                    Caption = 'Tarifa Descripción';
                    ToolTip = 'Tarifa Descripción';
                }
                field("Day Cost"; Rec."Day Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo por día';
                    Editable = false;
                    ToolTip = 'Costo por día';
                }
                field("Mouth Cost"; Rec."Mouth Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo de boca';
                    Editable = false;
                    ToolTip = 'Costo de boca';
                }
                field("Year Cost"; Rec."Year Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo anual';
                    Editable = false;
                    ToolTip = 'Costo anual';
                }
                field("Deliver/Pickup Price"; Rec."Deliver/Pickup Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de entrega/recogida';
                    ToolTip = 'Precio de entrega/recogida';
                }
                field("Print Order"; Rec."Print Order")
                {
                    ApplicationArea = All;
                    Caption = 'Orden de impresión';
                    ToolTip = 'Orden de impresión';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'Funci&ones';
                action("Load Service Rate")
                {
                    Caption = 'Volcar Tarifa de Servicio';
                    Image = LinesFromJob;

                    trigger OnAction();
                    var
                        GetServRatePlatformGroups: Report "Get Serv Rate Platform Groups";
                        PlatfServQInvGLine: Record "Platf. Serv. Q. Inv G Line_LDR";
                    begin
                        Clear(PlatfServQInvGLine);
                        PlatfServQInvGLine.setRange("Quote No.", Rec."Quote No.");
                        if PlatfServQInvGLine.FindFirst then
                            if not confirm(Text001, false, Rec."Quote No.") then
                                Error('');


                        Clear(GetServRatePlatformGroups);
                        GetServRatePlatformGroups.SetParams(Rec."Quote No.");
                        GetServRatePlatformGroups.runModal;

                        CurrPage.update(false);
                    end;
                }
            }
        }
    }

    var
        Text001: TextConst ENU = 'Platform Quote No. %1, already has some Invoice Groups specified. By continuing you will add all the Service Rate''s Invoices Groups to the existing ones.', ESP = 'La Oferta de Plataformas Nº %1, ya tiene algun grupo de facturación especificado. Continuando se añadirán todos los grupos de facturación presentes en la Tarifa de Servicio.';
}

