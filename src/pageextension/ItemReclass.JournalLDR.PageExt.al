/// <summary>
/// PageExtension Item Reclass. Journal_LDR (ID 50072) extends Record Item Reclass. Journal.
/// </summary>
pageextension 50072 "Item Reclass. Journal_LDR" extends "Item Reclass. Journal"
{
    layout
    {
        addafter("Document Date")
        {
            field("EAN code_LDR"; Rec."EAN code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código EAN';
                ToolTip = 'Código EAN';
            }
        }
        addafter("Item No.")
        {
            field("New Serial No."; Rec."New Serial No.")
            {
                ApplicationArea = All;
                Caption = 'Nuevo número de serie';
                ToolTip = 'Nuevo número de serie';
            }
        }
        addafter(Description)
        {
            field("No. EAN labels_LDR"; Rec."No. EAN labels_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nº etiquetas EAN';
                ToolTip = 'Nº etiquetas EAN';
            }
            field("Default Bin Destination_LDR"; Rec."Default Bin Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino de contenedor predeterminado';
                ToolTip = 'Destino de contenedor predeterminado';
            }
        }
        addafter("Unit Cost")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                Caption = 'Tipo de orden';
                ToolTip = 'Tipo de orden';
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = 'N º de pedido.';
                ToolTip = 'N º de pedido.';
            }
            field("Service Item Line No._LDR"; Rec."Service Item Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de línea de artículo de servicio';
                ToolTip = 'Número de línea de artículo de servicio';
            }
        }
        addafter(ItemDescription)
        {
            group("Source Inventory")
            {
                Caption = 'Inventario Origen';
            }
            field(SourceInventory; SourceInventory)
            {
                ApplicationArea = All;
                Caption = 'Inventario de origen';
                ToolTip = 'Inventario de origen';
            }
            group("Destination Inventory")
            {
                Caption = 'Inventario Destino';
            }
            field(DestinationInventory; DestinationInventory)
            {
                ApplicationArea = All;
                Caption = 'Inventario de destino';
                ToolTip = 'Inventario de destino';
            }
        }
    }

    actions
    {
        addafter("Get Bin Content")
        {
            separator(Separator1)
            {

            }
            action("Get Purch. Receipt")
            {
                ApplicationArea = All;
                Caption = 'Traer Alb. &Compra';

                trigger OnAction()
                var
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                //GetReceipts: Page 7122059;//TODO: No encontrado
                begin
                    CLEAR(PurchRcptLine);
                    PurchRcptLine.FILTERGROUP(2);

                    PurchRcptLine.SETFILTER(PurchRcptLine."Demand Location Code_LDR", '<>%1', '');
                    PurchRcptLine.SETRANGE(PurchRcptLine.Reclasified_LDR, FALSE);
                    PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);

                    IF PurchRcptLine.FINDSET THEN BEGIN
                        REPEAT
                            IF PurchRcptLine."Demand Location Code_LDR" <> PurchRcptLine."Location Code" THEN
                                PurchRcptLine.MARK(TRUE)
                            ELSE
                                PurchRcptLine.MARK(FALSE);

                        UNTIL PurchRcptLine.NEXT = 0;
                        PurchRcptLine.MARKEDONLY(TRUE);
                    END;

                    PurchRcptLine.FILTERGROUP(0);
                    //GetReceipts.SETTABLEVIEW(PurchRcptLine);
                    //GetReceipts.LOOKUPMODE := TRUE;
                    //GetReceipts.SetSection(Rec."Journal Template Name", Rec."Journal Batch Name");
                    //GetReceipts.RUNMODAL;
                end;
            }
            separator(Separator2)
            {

            }
            action("Propose Reclasf. Journal")
            {
                ApplicationArea = All;
                Caption = 'Proponer &Reclasificaci¢n';

                trigger OnAction()
                var
                    serviceLine: Record "Service Line";
                //getServLines: Page 7122105; //TODO: No encontrado
                begin
                    CLEAR(serviceLine);
                    serviceLine.FILTERGROUP(2);
                    serviceLine.SETRANGE("Document Type", serviceLine."Document Type"::Order);
                    serviceLine.SETRANGE(Type, serviceLine.Type::Item);
                    serviceLine.SETFILTER("Location Code", '<>%1', '');
                    serviceLine.SETRANGE(Reclasified_LDR, false);
                    serviceLine.SETFILTER(Quantity, '<>%1', 0);
                    IF serviceLine.FINDSET THEN;
                    serviceLine.FILTERGROUP(0);

                    //getServLines.SETTABLEVIEW(serviceLine);
                    //getServLines.LOOKUPMODE := TRUE;
                    //getServLines.SetSection(Rec."Journal Template Name", Rec."Journal Batch Name");
                    //getServLines.RUNMODAL;
                end;
            }
            separator(Separator3)
            {

            }
            action("Propose Realized Consumption")
            {
                ApplicationArea = All;
                Caption = 'Proponer Consumos Realizados';

                trigger OnAction()
                var
                    serviceLine: Record "Service Line";
                //getServLines: Page 7122113; //TODO: No encontrado
                begin
                    CLEAR(serviceLine);
                    serviceLine.FILTERGROUP(2);

                    serviceLine.SETRANGE("Document Type", serviceLine."Document Type"::Order);
                    serviceLine.SETRANGE(Type, serviceLine.Type::Item);
                    serviceLine.SETFILTER("Location Code", '<>%1', '');
                    serviceLine.SETFILTER(Quantity, '<>%1', 0);
                    IF serviceLine.FINDSET THEN;

                    serviceLine.FILTERGROUP(0);
                    //getServLines.SETTABLEVIEW(serviceLine);
                    //getServLines.LOOKUPMODE := TRUE;
                    //getServLines.SetSection(Rec."Journal Template Name", Rec."Journal Batch Name");
                    //getServLines.RUNMODAL;
                end;
            }
            separator(Separator4)
            {

            }
            group("Print Labels")
            {
                Caption = 'Imprimir Etiquetado';
                Image = BarCode;
            }
            action("Print Intermec Labels")
            {
                ApplicationArea = All;
                Caption = 'Imprimir Reetiquetado &INTERMEC';
                Image = BarCode;

                trigger OnAction()
                var
                    RecItemJournal: Record "Item Journal Line";
                    Orden: File;
                    //FuncionesEAN: Codeunit 7122015; //TODO: No encontrada
                    Rutafichero: Text;
                    //Environment: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Environment"; //TODO: Desconozco su funcionamiento
                    ServerTempFileName: Text;
                    FileMgt: Codeunit "File Management";
                begin
                    RecItemJournal.COPY(Rec);

                    IF RecItemJournal.FINDSET THEN BEGIN
                        ServerTempFileName := FileMgt.ServerTempFileName('txt');
                        Orden.WRITEMODE := false;
                        Orden.TEXTMODE := true;
                        //Rutafichero := Environment.GetEnvironmentVariable('userprofile');
                        Orden.CREATE(ServerTempFileName);
                        REPEAT
                            IF RecItemJournal."No. EAN labels_LDR" <> 0 THEN
                                Orden.WRITE('{IMPR#1#' + FORMAT(RecItemJournal."No. EAN labels_LDR") + '#' + FORMAT(RecItemJournal.Description) + '#'
                                                      //+ FuncionesEAN.GetEAN(RecItemJournal."Item No.") + '#' + FORMAT(RecItemJournal."Item No.")
                                                      + '#' + FORMAT(RecItemJournal."New Bin Code") + '#}');

                        UNTIL RecItemJournal.NEXT = 0;
                        Orden.CLOSE;
                        //FileMgt.DownloadToFile(ServerTempFileName, Rutafichero + '\Etiquetas.txt');//TODO:DownloadToFile no se encuentra y hay varios metodos similares
                        SLEEP(1000);
                        //FuncionesEAN.EjecutarImpresion(REPORT::Report7122020); //TODO: Report no encontrado
                    END;
                end;
            }
            action("Print EAN 13 Labels")
            {
                ApplicationArea = All;
                Caption = 'Imprimir Reetiquetado &EAN 13';
                Image = BarCode;

                trigger OnAction()
                var
                    RecItemJournal: Record "Item Journal Line";
                    //ReportSelection: Record 7122074; //TODO: No encontrada
                    RecBinContent: Record "Bin Content";
                    invSetup: Record "Inventory Setup";
                    NewRecBinContent: Record "Bin Content";
                    I: Integer;
                begin
                    RecItemJournal.Copy(Rec);
                    CurrPage.SETSELECTIONFILTER(RecItemJournal);
                    //ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"5"); //TODO: Usage no se encuentra
                    //ReportSelection.FINDSET;
                    //REPEAT
                    //REPORT.RUNMODAL(ReportSelection."Report ID", TRUE, FALSE, RecItemJournal); 
                    //UNTIL ReportSelection.NEXT = 0;
                end;
            }
        }
    }


    procedure CalcInventory()
    var
        Item: Record Item;
        Item2: Record Item;
    begin
        SourceInventory := 0;
        IF (Rec."Item No." <> '') THEN BEGIN
            Item.GET(Rec."Item No.");
            IF Rec."Variant Code" <> '' THEN
                Item.SETFILTER("Variant Filter", Rec."Variant Code");
            IF Rec."Location Code" <> '' THEN
                Item.SETFILTER("Location Filter", Rec."Location Code");

            Item.CALCFIELDS(Inventory);
            SourceInventory := Item.Inventory;


            Item2.GET(Rec."Item No.");
            IF Rec."Variant Code" <> '' THEN
                Item2.SETFILTER("Variant Filter", Rec."Variant Code");
            IF Rec."New Location Code" <> '' THEN
                Item2.SETFILTER("Location Filter", Rec."New Location Code");

            Item2.CALCFIELDS(Inventory);
            DestinationInventory := Item2.Inventory;

        END;
    end;

    var
        ItemJournalBatch: Record "Item Journal Batch";
        ServHeader: Record "Service Header";
        ItemJournalLine: Record "Item Journal Line";
        SourceInventory: Decimal;
        DestinationInventory: Decimal;
        Text006: Label 'El N§ de Documento de la linea %1 no se corresponde con ningun Pedido de Servicio abierto.';

}