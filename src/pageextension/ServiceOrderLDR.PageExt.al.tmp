pageextension 50111 "ServiceOrder_LDR" extends "Service Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Customer Comment")
            {
                ApplicationArea = All;
                Caption = 'Comentario Cliente';
                Image = Comment;

                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = CONST(Customer),
                                "No." = FIELD("Customer No.");
            }
            group("Comm&ents")
            {
                Caption = 'Come&ntarios';
                Image = ViewComments;
            }
            action(Faults)
            {
                ApplicationArea = All;
                Caption = 'Defectos';
                Promoted = true;
                PromotedIsBig = true;
                Image = Error;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    CurrPage.ServItemLines.PAGE.ShowAdvancedComments(1);
                end;
            }
            action(Resolutions)
            {
                ApplicationArea = All;
                Caption = 'Resoluciones';
                Promoted = true;
                PromotedIsBig = true;
                Image = Completed;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    CurrPage.ServItemLines.PAGE.ShowAdvancedComments(2);
                end;
            }
            action(Internal)
            {
                ApplicationArea = All;
                Caption = 'Interno';
                Promoted = true;
                PromotedIsBig = true;
                Image = Comment;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    CurrPage.ServItemLines.PAGE.ShowAdvancedComments(4);
                end;
            }
        }
        addafter("Create Customer")
        {
            group("Print Labels")
            {
                Caption = 'Imprimir Etiquetado';
                Image = BarCode;
            }
            action(PrintIntermec)
            {
                ApplicationArea = All;
                Caption = 'Imprimir Intermec';
                Promoted = true;
                Image = BarCode;

                trigger OnAction()
                var
                    PostedSerHeader: Record "Posted Service Header_LDR";
                    reportSelection: Record "Report Selections Labels_LDR";
                begin
                    CLEAR(PostedSerHeader);
                    PostedSerHeader.SETRANGE(PostedSerHeader."No.", Rec."No.");
                    IF PostedSerHeader.FINDSET THEN
                        REPORT.RUNMODAL(REPORT::Report7122024, TRUE, FALSE, PostedSerHeader);
                end;
            }
            action(PrintLabel)
            {
                ApplicationArea = All;
                Caption = 'Imprimir Etiqueta EAN13';
                Promoted = true;
                Image = BarCode;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ServItemLine: Record "Service Item Line";
                    ServiceItem: Record "Service Item";
                    reportSelection: Record "Report Selections Labels_LDR";
                    i: Integer;
                    EANServItem: Report 70120;
                begin
                    CLEAR(ServItemLine);
                    ServItemLine.SETRANGE(ServItemLine."Document No.", Rec."No.");

                    IF ServItemLine.FINDSET THEN BEGIN
                        CLEAR(ServiceItem);
                        REPEAT
                            ServiceItem.RESET;
                            ServiceItem.SETRANGE("No.", ServItemLine."Service Item No.");
                            IF ServiceItem.FINDFIRST THEN BEGIN
                                reportSelection.SETRANGE(Usage, reportSelection.Usage::"Serv. Item");
                                reportSelection.FINDFIRST;
                                REPEAT
                                    IF reportSelection."Report ID" = 7122151 THEN BEGIN
                                        EANServItem.SETTABLEVIEW(ServiceItem);
                                        EANServItem.SetServHeaderNo(Rec."No.");
                                        EANServItem.RUNMODAL();
                                    END ELSE
                                        REPORT.RUNMODAL(reportSelection."Report ID", FALSE, FALSE, ServiceItem);
                                UNTIL reportSelection.NEXT = 0;
                            END;
                        UNTIL ServItemLine.NEXT = 0;
                    END;
                end;
            }
            action("Copy Service Order Lines")
            {
                ApplicationArea = All;
                Caption = 'C&opiar Lineas Pedido Servicio';
                Image = Copy;

                trigger OnAction()
                var
                    CopyServiceDoc: Report 70037;
                begin
                    CopyServiceDoc.SetServiceHeader(Rec);
                    CopyServiceDoc.RUNMODAL;
                    CLEAR(CopyServiceDoc);
                end;
            }
            group("Create Alarm for")
            {
                Caption = 'Crear Alarma para';
                Image = Alerts;
            }
            action(Customer)
            {
                ApplicationArea = All;
                Caption = 'Cliente';

                trigger OnAction()
                begin
                    Rec.CreateAlarmFor(1);
                end;
            }
            action("Service Item")
            {
                ApplicationArea = All;
                Caption = 'Producto Servicio';

                trigger OnAction()
                begin
                    Rec.CreateAlarmFor(2);
                end;
            }
            action(Contract)
            {
                ApplicationArea = All;
                Caption = 'Contrato';
                Image = Document;

                trigger OnAction()
                begin
                    Rec.CreateAlarmFor(3);
                end;
            }
        }
        addafter("Create Whse Shipment")
        {
            group(Invoicing)
            {
                Caption = 'Facturación';
            }
            action("Create Invoicing Plan")
            {
                ApplicationArea = All;
                Caption = 'Crear Plan de Facturaci¢n';

                trigger OnAction()
                var
                    ServiceOrderMgt: Codeunit "Service Order Mgt._LDR";
                    Result: Boolean;
                begin
                    ServiceOrderMgt.ProcessOrderToInvoice(Rec."No.", TRUE, Result);

                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        addafter(PostBatch)
        {
            separator("")
            {
                Caption = '';
            }
            action("Send to Posted Service Orders")
            {
                ApplicationArea = All;
                Caption = 'Pasar a Hist¢ricos';
                Image = PostSendTo;

                trigger OnAction()
                var
                    CduHistoricos: Report 50205;
                    CduIntCompInvoicing: Codeunit "Intercompany invoicing_LDR";
                begin
                    ServHeader.GET(Rec."Document Type", Rec."No.");
                    CduHistoricos.RUNO(ServHeader);
                end;
            }
            group("group1")
            {

            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Imprimir Partes de Trabajo';
                Image = Print;

                trigger OnAction()
                var
                    ReportSelection: Record "Report Selections";
                    ServiceHeader: Record "Service Header";
                begin
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"S.Order");
                    ReportSelection.SETFILTER("Report ID", '<>0');
                    IF ReportSelection.FINDSET THEN BEGIN
                        CLEAR(ServiceHeader);
                        ServiceHeader.SETRANGE("Document Type", Rec."Document Type");
                        ServiceHeader.SETRANGE("No.", Rec."No.");
                        REPEAT
                            REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, ServiceHeader);
                        UNTIL ReportSelection.NEXT() = 0;
                    END;
                end;
            }
            action("Print DDT")
            {
                ApplicationArea = All;
                Caption = 'Imprimir Documento Transporte Plataforma';
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetVisibility();
    end;

    var
        myInt: Integer;
}