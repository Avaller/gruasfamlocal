/// <summary>
/// Page Crane Service Quote Card (ID 50024).
/// </summary>
page 50024 "Crane Service Quote Card"
{
    Caption = 'Crane Service Quote Card';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Crane Service Quote Header_LDR";
    SourceTableView = where("Historical" = Const(false), "Platform Quote" = Const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Quote no."; Rec."Quote no.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cita';
                    Importance = Promoted;
                    ToolTip = 'No de Cita';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.upDate;
                    end;
                }
                field("Quote Type"; Rec."Quote Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Cita';
                    Importance = Promoted;
                    ToolTip = 'Tipo de Cita';

                    trigger OnValidate()
                    begin
                        upDatefields;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción 2';
                    ToolTip = 'Descripción 2';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cliente';
                    Importance = Promoted;
                    ToolTip = 'No de Cliente';

                    trigger OnValidate()
                    begin
                        CurrPage.upDate;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Cliente';
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Nombre de Cliente';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Contacto';
                    ToolTip = 'No de Contacto';

                    trigger OnValidate()
                    begin
                        CurrPage.upDate;
                    end;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Contacto';
                    ToolTip = 'Nombre de Contacto';
                }
                field("Ship-to Address Code"; Rec."Ship-to Address Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Dirección de Envio';
                    Importance = Promoted;
                    ToolTip = 'Codigo de Dirección de Envio';

                    trigger OnValidate()
                    begin
                        CurrPage.upDate;
                    end;
                }
                field("Ship-to Address Name"; Rec."Ship-to Address Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Dirección de Envio';
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Nombre de Dirección de Envio';
                }
                field("Rate Code"; Rec."Rate Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Valoración';
                    ToolTip = 'Codigo de Valoración';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Inicio';
                    ToolTip = 'Fecha de Inicio';
                }
                field("ending Date"; Rec."ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Fin';
                    ToolTip = 'Fecha de Fin';
                }
                field("Quote Date"; Rec."Quote Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de cotización';
                    ToolTip = 'Fecha de cotización';
                }
                field("Quote Status"; Rec."Quote Status")
                {
                    ApplicationArea = All;
                    Caption = 'Estado de Cotización';
                    Editable = false;
                    ToolTip = 'Estado de Cotización';
                }
                field("External document No."; Rec."External document No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Documento Externo';
                    ToolTip = 'No de Documento Externo';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de vendedor';
                    ToolTip = 'Código de vendedor';
                }
                field("Responsability Center"; Rec."Responsability Center")
                {
                    ApplicationArea = All;
                    Caption = 'Centro de Responsabilidad';
                    ToolTip = 'Centro de Responsabilidad';
                }
            }
            group(Surcharge)
            {
                Caption = 'Surcharge';
                field("Apply Saturday Surcharge"; Rec."Apply Saturday Surcharge")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar recargo de sábado';
                    ToolTip = 'Aplicar recargo de sábado';
                }
                field("Apply Festive Surcharge"; Rec."Apply Festive Surcharge")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar recargo de festival';
                    ToolTip = 'Aplicar recargo de festival';
                }
                field("Apply Night Surcharge"; Rec."Apply Night Surcharge")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar Recargo Nocturno';
                    ToolTip = 'Aplicar Recargo Nocturno';
                }
                field("Apply Minimum"; Rec."Apply Minimum")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar Minimo';
                    ToolTip = 'Aplicar Minimo';
                }
                field("Fill minimum with Displ."; Rec."Fill minimum with Displ.")
                {
                    ApplicationArea = All;
                    Caption = 'Rellenar mínimo con Display';
                    ToolTip = 'Rellenar mínimo con Display';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        upDatefields;
                    end;
                }
            }
            group(Dispacement)
            {
                Caption = 'Dispacement';
                field("Invoice Displacement"; Rec."Invoice Displacement")
                {
                    ApplicationArea = All;
                    Caption = 'Desplazamiento de factura';
                    ToolTip = 'Desplazamiento de factura';

                    trigger OnValidate()
                    begin
                        upDatefields;
                    end;
                }
                field("Invoice Exit Fee"; Rec."Invoice Exit Fee")
                {
                    ApplicationArea = All;
                    Caption = 'Tarifa de salida de factura';
                    ToolTip = 'Tarifa de salida de factura';
                }
                field("Apply Standard KMs"; Rec."Apply Standard KMs")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar KM estándar';
                    ToolTip = 'Aplicar KM estándar';

                    trigger OnValidate()
                    begin
                        upDatefields;
                    end;
                }
                field("Displacement Type"; Rec."Displacement Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Desplacamiento';
                    Importance = Promoted;
                    ToolTip = 'Tipo de Desplacamiento';

                    trigger OnValidate()
                    begin
                        upDatefields;
                    end;
                }
                field("Displacement %"; Rec."Displacement %")
                {
                    ApplicationArea = All;
                    Caption = 'Desplazamiento %';
                    ToolTip = 'Desplazamiento %';
                }
                field("KM Franchise"; Rec."KM Franchise")
                {
                    ApplicationArea = All;
                    Caption = 'Desplazamiento %';
                    Enabled = KMsFranchiseEnabled;
                    ToolTip = 'Desplazamiento %';
                }
                field("KM/Time"; Rec."KM/Time")
                {
                    ApplicationArea = All;
                    Caption = 'KM/Tiempo';
                    Enabled = KmsHoursEnabled;
                    ToolTip = 'KM/Tiempo';
                }
                field("Displacement Amount"; Rec."Displacement Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Canttidad de Desplazamiento';
                    Enabled = DiplacementAmountEnabled;
                    ToolTip = 'Canttidad de Desplazamiento';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Group Invoices"; Rec."Group Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Facturas de grupo';
                    ToolTip = 'Facturas de grupo';
                    Visible = false;
                }
                field("Inv. Group Code"; Rec."Inv. Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Inv. de codigo del grupo';
                    Importance = Promoted;
                    ToolTip = 'Inv. de codigo del grupo';
                    Visible = false;
                }
                field("Invoice Period"; Rec."Invoice Period")
                {
                    ApplicationArea = All;
                    Caption = 'Período de facturación';
                    Importance = Promoted;
                    ToolTip = 'Período de facturación';
                }
                field("Invoicing Type"; Rec."Invoicing Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de facturación';
                    ToolTip = 'Tipo de facturación';
                }
                field(Retained; Rec.Retained)
                {
                    ApplicationArea = All;
                    Caption = 'Retención';
                    Enabled = false;
                    ToolTip = 'Retención';
                }
                field("Customer Order No."; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de pedido del cliente';
                    Enabled = bCustOrderNo;
                    ToolTip = 'Número de pedido del cliente';

                    trigger OnValidate()
                    begin
                        upDatefields;
                    end;
                }
                field("Skip Invoice split on Orders"; Rec."Skip Invoice split on Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Omitir división de factura en pedidos';
                    ToolTip = 'Omitir división de factura en pedidos';
                }
            }
            part(Operations; "Service Crane Quote Op. Subf.")
            {
                Caption = 'Operations';
                SubPageLink = "Quote No." = field("Quote no.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(action)
            {
                action(Lock)
                {
                    Caption = 'Lock';
                    Image = Lock;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.LockQuote;
                        CurrPage.upDate(false);
                    end;
                }
                action(Open)
                {
                    Caption = 'Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.OpenQuote;
                        CurrPage.upDate(false);
                    end;
                }
            }
            group(action2)
            {
                action("Reject Quote")
                {
                    Caption = 'Reject Quote';
                    Image = Reject;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.RejectQuote;
                        CurrPage.upDate(false);
                    end;
                }
                action("Send to Archive")
                {
                    Caption = 'Send to Archive';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        Rec.SendToArchive;
                        CurrPage.upDate(false);
                    end;
                }
                action("Create Invoice")
                {
                    Caption = 'Create Invoice';

                    trigger OnAction()
                    var
                        InvoicingForfaitQuote: Codeunit "Invoicing Forfait Quote_LDR";
                    begin
                        //InvoicingForfaitQuote.run(Rec);
                        ServiceQuoteMgt.InvoiceForfaitCraneQuote(Rec);
                    end;
                }
                action("Apply Serv. Rate on Quote")
                {
                    Caption = 'Apply Serv. Rate on Quote';
                    Image = ApplyEntries;

                    trigger OnAction()
                    var
                        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
                    begin
                        if Confirm(Text0001) then begin
                            Rec.TestField("Quote Status", Rec."Quote Status"::Open);
                            Clear(CraneServiceQuoteHeader);
                            CraneServiceQuoteHeader.SetRange("Quote no.", CraneServiceQuoteHeader."Quote no.");
                            Report.run(Report::"Apply Serv. Rate on Quotes", true, true, CraneServiceQuoteHeader);
                            CurrPage.upDate(false);
                        end;
                    end;
                }
            }
            group(action3)
            {
                action("Report by Offer")
                {
                    Caption = 'Report by Offer';
                    Image = Print;

                    trigger OnAction()
                    var
                        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
                    begin
                        clear(CraneServiceQuoteHeader);
                        CraneServiceQuoteHeader.SetRange("Quote no.", CraneServiceQuoteHeader."Quote no.");
                        Report.run(Report::"Crane Report by Offer", true, true, CraneServiceQuoteHeader);
                    end;
                }
                action("Print Crane Quote")
                {
                    Caption = 'Print Crane Quote';
                    Image = Print;

                    trigger OnAction()
                    var
                        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
                        Text000: Label '&Rate Format,&Special Operations Format';
                        Selection: Integer;
                    begin
                        clear(CraneServiceQuoteHeader);
                        CraneServiceQuoteHeader.SetRange("Quote no.", CraneServiceQuoteHeader."Quote no.");
                        CraneServiceQuoteHeader.findSet;
                        if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::Forfait then
                            Report.run(Report::"Forfait Crane Quote", true, true, CraneServiceQuoteHeader)
                        else
                            if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::Tariff then begin
                                //PCO 16/01/2020 DEciden no poder imprimir oferta de tarifa al poder confundir por tener tarifa en cabecera <> tarifa en lineas.
                                //
                                //  Selection := STRMENU(Text000,1);
                                //  // end : ALQUINTA
                                //  if Selection = 0 then
                                //    EXIT
                                //  else if Selection = 1 then
                                //    Report.run(Report::"Rate Crane Quote",true,true,CraneServiceQuoteHeader)
                                //  else if Selection = 2 then
                                Report.run(Report::"Crane Quote", true, true, CraneServiceQuoteHeader);
                            end else
                                if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::General then begin
                                    //SIEMPRE SE IMPRIME COMO OP ESPECIAL
                                    //Report.run(Report::"Rate Crane Quote",true,true,CraneServiceQuoteHeader)
                                    Report.run(Report::"Crane Quote", true, true, CraneServiceQuoteHeader);
                                end else
                                    ERROR('');//Report.run(Report::"Crane Quote",true,true,CraneServiceQuoteHeader);
                    end;
                }
            }
        }
        area(navigation)
        {
            action("Co&mments")
            {
                Caption = 'Co&mments';
                Image = ViewComments;
                runObject = Page "Service Comment Sheet";
                runPageLink = "Type" = Const(General),
                              "Table Subtype" = Const(0),
                              "Table Name" = Const("Crane Quote"),
                              "No." = field("Quote no."),
                              "Table Line No." = Const(0);
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        upDatefields;
    end;

    trigger OnAfterGetRecord()
    begin
        upDatefields;
    end;

    trigger OnOpenPage()
    begin
        upDatefields;
    end;

    var
        [InDataSet]
        DisplacementCalcTypeEnabled: Boolean;
        [InDataSet]
        KMsFranchiseEnabled: Boolean;
        [InDataSet]
        KmsHoursEnabled: Boolean;
        [InDataSet]
        DiplacementAmountEnabled: Boolean;
        ServiceQuoteMgt: Codeunit "Service Quote Mgt._LDR";
        bCustOrderNo: Boolean;
        Text0001: Label 'By modifying the Service Rate on this quote, ALL lines will be affected. This will not apply to the existing Service Order or Contracts\Are you sure you want to proceed?';

    local procedure upDatefields()
    begin
        //RQ19.12.442 MSOPENA
        bCustOrderNo := false;
        if (Rec."Quote Type" = Rec."Quote Type"::Forfait) AND (Rec."Invoicing Type" = Rec."Invoicing Type"::Order) then begin
            bCustOrderNo := true;
            Rec.Retained := true;
            if Rec."Customer Order No." <> '' then
                Rec.Retained := false;
        end;
        //-------------------
        if Rec."Displacement Type" = Rec."Displacement Type"::KMs then begin
            if NOT Rec."Apply Standard KMs" then begin
                DisplacementCalcTypeEnabled := true;
                KMsFranchiseEnabled := false;
            end else begin
                DisplacementCalcTypeEnabled := false;
                KMsFranchiseEnabled := true;
            end;

            if Rec."Apply Standard KMs" then begin
                KmsHoursEnabled := false;
                DiplacementAmountEnabled := false;
            end else begin
                KmsHoursEnabled := true;
                DiplacementAmountEnabled := true;
            end;
        end else begin
            KMsFranchiseEnabled := false;

            if NOT Rec."Apply Standard KMs" then begin
                DisplacementCalcTypeEnabled := true;
            end else begin
                DisplacementCalcTypeEnabled := false;
            end;

            if Rec."Apply Standard KMs" then begin
                KmsHoursEnabled := false;
                DiplacementAmountEnabled := false;
            end else begin
                KmsHoursEnabled := true;
                DiplacementAmountEnabled := true;
            end;
        end;
    end;
}