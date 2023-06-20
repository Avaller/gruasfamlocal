/// <summary>
/// 
/// 
/// </summary>
page 50104 "Platform Service Quote Card"
{
    Caption = 'Platform Service Quote Card';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Crane Service Quote Header_LDR";
    SourceTableView = where("Historical" = Const(false), "Platform Quote" = Const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Quote no."; Rec."Quote no.")
                {
                    ApplicationArea = All;
                    Caption = 'Cotización n.º';
                    Importance = Promoted;
                    ToolTip = 'Cotización n.º';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Quote Type"; Rec."Quote Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de cotización';
                    Importance = Promoted;
                    ToolTip = 'Tipo de cotización';

                    trigger OnValidate()
                    begin
                        Updatefields;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de cliente';
                    Importance = Promoted;
                    ToolTip = 'Número de cliente';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del cliente';
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Nombre del cliente';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contacto';
                    ToolTip = 'Nº de contacto';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de contacto';
                    ToolTip = 'Nombre de contacto';
                }
                field("Ship-to Address Code"; Rec."Ship-to Address Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dirección de envío';
                    Importance = Promoted;
                    ToolTip = 'Código de dirección de envío';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Ship-to Address Name"; Rec."Ship-to Address Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de la dirección de envío';
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Nombre de la dirección de envío';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio';
                    ToolTip = 'Fecha de inicio';
                }
                field("ending Date"; Rec."ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización';
                    ToolTip = 'Fecha de finalización';
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
                    Caption = 'Estado de cotización';
                    Editable = false;
                    ToolTip = 'Estado de cotización';
                }
                field("External document No."; Rec."External document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Documento externo n.º';
                    ToolTip = 'Documento externo n.º';
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
                field("Rate Code"; Rec."Rate Code")
                {
                    ApplicationArea = All;
                    Caption = 'código de tarifa';
                    ToolTip = 'código de tarifa';
                }
            }
            group(Surcharge)
            {
                Caption = 'Surcharge';
                Visible = false;
                field("Apply Saturday Surcharge"; Rec."Apply Saturday Surcharge")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar recargo de sábado';
                    ToolTip = 'Aplicar recargo de sábado';
                }
                field("Apply Festive Surcharge"; Rec."Apply Festive Surcharge")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar Recargo Festivo';
                    ToolTip = 'Aplicar Recargo Festivo';
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
                    Caption = 'Aplicar mínimo';
                    ToolTip = 'Aplicar mínimo';
                }
                field("Invoice Displacement"; Rec."Invoice Displacement")
                {
                    ApplicationArea = All;
                    Caption = 'Desplazamiento de factura';
                    ToolTip = 'Desplazamiento de factura';

                    trigger OnValidate()
                    begin
                        Updatefields;
                    end;
                }
                field("Fill minimum with Displ."; Rec."Fill minimum with Displ.")
                {
                    ApplicationArea = All;
                    Caption = 'Rellenar mínimo con Display';
                    ToolTip = 'Rellenar mínimo con Display';

                    trigger OnValidate()
                    begin
                        Updatefields;
                    end;
                }
                field("Invoice Exit Fee"; Rec."Invoice Exit Fee")
                {
                    ApplicationArea = All;
                    Caption = 'Cuota de salida de factura';
                    ToolTip = 'Cuota de salida de factura';
                }
            }
            group(Displacement)
            {
                Caption = 'Displacement';
                Visible = false;
                field("Apply Standard KMs"; Rec."Apply Standard KMs")
                {
                    ApplicationArea = All;
                    Caption = 'Desplazamiento';
                    ToolTip = 'Desplazamiento';

                    trigger OnValidate()
                    begin
                        Updatefields;
                    end;
                }
                field("Displacement Type"; Rec."Displacement Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de desplazamiento';
                    Importance = Promoted;
                    ToolTip = 'Tipo de desplazamiento';

                    trigger OnValidate()
                    begin
                        Updatefields;
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
                    Caption = 'Franquicia KM';
                    Enabled = KMsFranchiseEnabled;
                    ToolTip = 'Franquicia KM';
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
                    Caption = 'Cantidad de desplazamiento';
                    Enabled = DiplacementAmountEnabled;
                    ToolTip = 'Cantidad de desplazamiento';
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
                    Caption = 'Inversión del codigo del grupo';
                    Importance = Promoted;
                    ToolTip = 'Inversión del codigo del grupo';
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
            }
            part(Lines; "Plat. Serv. Q. Inv. G Line")
            {
                Caption = 'Lines';
                SubPageLink = "Quote No." = field("Quote no.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Status)
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
                        CurrPage.Update(false);
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
                        CurrPage.Update(false);
                    end;
                }
            }
            group(Receipt)
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
                        CurrPage.Update(false);
                    end;
                }
                action("Send to Archive")
                {
                    Caption = 'Send to Archive';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        Rec.SendToArchive;
                        CurrPage.Update(false);
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
                        if CONFIRM(Text0001) then begin
                            Rec.TestField(Rec."Quote Status", Rec."Quote Status"::Open);
                            CLEAR(CraneServiceQuoteHeader);
                            CraneServiceQuoteHeader.SETRANGE("Quote no.", Rec."Quote no.");
                            Report.Run(Report::"Apply Serv. Rate on Quotes", true, true, CraneServiceQuoteHeader);
                            CurrPage.Update(false);
                        end;
                    end;
                }
            }
            group(Print)
            {
                action("Print Platform Quote")
                {
                    Caption = 'Print Platform Quote';
                    Image = Print;

                    trigger OnAction()
                    var
                        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
                    begin
                        CLEAR(CraneServiceQuoteHeader);
                        CraneServiceQuoteHeader.SETRANGE("Quote no.", Rec."Quote no.");
                        CraneServiceQuoteHeader.FINDSET;
                        if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::Forfait then
                            Report.Run(Report::"Forfait Crane Quote", true, true, CraneServiceQuoteHeader)
                        else
                            if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::Tariff then
                                Report.Run(Report::"Platform Contract Quote", true, true, CraneServiceQuoteHeader)
                            else
                                if CraneServiceQuoteHeader."Quote Type" = CraneServiceQuoteHeader."Quote Type"::General then
                                    Report.Run(Report::"Platform Contract Quote", true, true, CraneServiceQuoteHeader)
                                else
                                    Error('');//Report.Run(Report::"Crane Quote",true,true,CraneServiceQuoteHeader);
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
                RunObject = Page "Service Comment Sheet";
                RunPageLink = Type = Const("General"),
                              "Table Subtype" = Const(0),
                              "Table Name" = Const("Crane Quote"),
                              "No." = field("Quote no."),
                              "Table Line No." = Const(0);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Updatefields;
    end;

    trigger OnOpenPage()
    begin
        Updatefields;
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

    local procedure Updatefields()
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