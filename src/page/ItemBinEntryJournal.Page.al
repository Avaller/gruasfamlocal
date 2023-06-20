page 50206 "Item Bin Entry Journal"
{
    /*AutoSplitKey = true;
    Caption = 'Item delivery/collection Journal';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = 70066;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Section Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): BoolEAN
                begin
                    CurrPage.SAVERECORD;
                    ItemBinEntryMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ItemBinEntryMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater()
            {
                field("Entry Type"; "Entry Type")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Serial No."; "Serial No.")
                {
                }
                field("Lot No."; "Lot No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Originally Vendor"; "Originally Vendor")
                {
                }
                field("Originally Name"; "Originally Name")
                {
                }
                field("Originally Vendor Ship Address"; "Originally Vendor Ship Address")
                {
                }
                field("Assignment Vendor"; "Assignment Vendor")
                {
                }
                field("Assignment Name"; "Assignment Name")
                {
                }
                field("Assignment Vendor Ship Address"; "Assignment Vendor Ship Address")
                {
                }
                field(Printed; Printed)
                {
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Fast Register"; "Fast Register")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    var
                        recLineaDiario: Record "70066";
                        text00: Label 'The Service Item: purchase Entry does not generate a document';
                    begin
                        // Comprobar si es compra no genera el word
                        recLineaDiario.COPY(Rec);
                        recLineaDiario.SETRECFILTER;
                        REPORT.RUN(REPORT::Report7122116, FALSE, TRUE, recLineaDiario);
                    end;
                }
            }
        }
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Item Entry-Post", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: BoolEAN)
    begin
        SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JnlSelected: BoolEAN;
    begin
        IF gShowSection <> '' THEN BEGIN
            CurrentJnlBatchName := gShowSection;
        END;
        ItemBinEntryMgt.TemplateSelection(PAGE::"Item Bin Entry Journal", FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ItemBinEntryMgt.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        CurrentJnlBatchName: Code[10];
        ItemBinEntryMgt: Codeunit "70036";
        ShortcutDimCode: array[8] of Code[20];
        gShowSection: Text[50];

    [Scope('Internal')]
    procedure ShowSection(SectionName: Text[50])
    begin
        gShowSection := SectionName;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemBinEntryMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end; */
}