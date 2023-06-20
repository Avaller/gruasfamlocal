/// <summary>
/// Page BreakDown Item Tree Detail (ID 50030).
/// </summary>
page 50030 "BreakDown Item Tree Detail"
{
    Caption = 'Item';
    PageType = ListPart;
    SourceTable = "Servic Item Breakd Detail_LDR";
    SourceTableView = Where(Identation = Const(2));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Item';
                    ToolTip = 'No de Item';
                    Visible = false;
                }
                field("Item No. 2"; Rec."Item No. 2")
                {
                    ApplicationArea = All;
                    Caption = 'No de Item 2';
                    ToolTip = 'No de Item 2';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de Item';
                    ToolTip = 'Descripción de Item';
                }
                field("Item Manufacturer Name"; Rec."Item Manufacturer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Item  de Fabricante';
                    ToolTip = 'Nombre de Item  de Fabricante';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Proveedor';
                    ToolTip = 'No de Proveedor';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    Caption = 'Inventario';
                    ToolTip = 'Inventario';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                action(ItemCard)
                {
                    Caption = '<Item Card>';
                    Image = Item;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = field("Item No.");
                }
                action(Stock)
                {
                    Caption = '<Stock>';
                    Image = GetActionMessages;
                    RunObject = Page "Bin Content";
                    RunPageLink = "Item No." = field("Item No.");
                }
                action(CreatePurchaseOrder)
                {
                    Caption = 'Create Purchase Order';
                    Image = Purchase;

                    trigger OnAction()
                    var
                        lVendorNo: Code[20];
                        ItemVendor: Record "Item Vendor";
                        ItemVendorCatalog: Page "Item Vendor Catalog";
                        PurchaseHeader: Record "Purchase Header";
                        Opencaption: Label 'Exists a purchase order open to this supplier, do you want to add to this order?';
                        PurchaseLine: Record "Purchase Line";
                        LastLineNo: Integer;
                        PurchaseOrder: Page "Purchase Order";
                        PurchaseOrderList: Page "Purchase Order List";
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        if Rec.findset then begin
                            Clear(ItemVendor);
                            ItemVendor.SetRange(ItemVendor."Item No.", ItemVendor."Item No.");
                            if ItemVendor.findset then begin
                                ItemVendorCatalog.SetTableView(ItemVendor);
                                ItemVendorCatalog.LookUpMode(true);
                                if ItemVendorCatalog.RunModal = ACTION::LookupOK then begin
                                    ItemVendorCatalog.GetRecord(ItemVendor);
                                    lVendorNo := ItemVendor."Vendor No.";
                                end else
                                    error('');
                                //Si solo tiene un registro.
                            end else begin
                                lVendorNo := ItemVendor."Vendor No.";
                            end;

                            Clear(PurchaseHeader);
                            PurchaseHeader.SetRange("Buy-from Vendor No.", lVendorNo);
                            PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Open);
                            if PurchaseHeader.findset then begin
                                PurchaseOrderList.SetTableView(PurchaseHeader);
                                PurchaseOrderList.LookUpMode(true);
                                if PurchaseOrderList.RunModal = ACTION::LookupOK then begin
                                    PurchaseOrderList.GetRecord(PurchaseHeader);
                                end else
                                    error('');
                            end else begin

                                PurchaseHeader.Init;
                                PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                                PurchaseHeader.Validate("Buy-from Vendor No.", lVendorNo);
                                PurchaseHeader.Insert(true);
                            end;

                            Clear(PurchaseLine);
                            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
                            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                            if PurchaseLine.FindLast then
                                LastLineNo := PurchaseLine."Line No."
                            else
                                LastLineNo := 0;

                            PurchaseLine.Init;
                            PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
                            PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
                            PurchaseLine.Validate("Line No.", LastLineNo + 10000);
                            PurchaseLine.Insert(true);
                            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                            PurchaseLine.Validate("No.", Rec."Item No.");
                            PurchaseLine.Modify(true);

                            PurchaseOrder.SetTableView(PurchaseHeader);
                            PurchaseOrder.RUN;
                        end
                        else
                            error(txter);
                    end;
                }
            }
        }
    }

    var
        txter: Label 'No service item line found.';
}