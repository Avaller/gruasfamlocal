/// <summary>
/// Table Armopa Distribution_LDR (ID 50215)
/// </summary>
table 50215 "Armopa Distribution_LDR"
{

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant"."Code" WHERE("Item No." = FIELD("Item No."));
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'UserID';
        }
        field(50012; "Armopa Qty. to Order"; Decimal)
        {
            Caption = 'Armopa Qty. to Order';
            MinValue = 0;

            trigger OnValidate()
            var
                StockKeeping: Record "Stockkeeping Unit";
            begin
                // Permitir demandar mas que el stock
                /*
                StockKeeping.GET("Location Code","Item No.","Variant Code");
                
                StockKeeping.CALCFIELDS("Main Location Code");
                StockKeeping.CALCFIELDS("Main Location Inventory");
                
                IF "Armopa Qty. to Order" > StockKeeping."Main Location Inventory" THEN
                  ERROR(STRSUBSTNO(Text50001,"Item No.","Location Code"));
                 */

            end;
        }
        field(50013; "Armopa Generate"; BoolEAN)
        {
            Caption = 'Armopa Generate';
        }
        field(50014; "Calc Armopa Qty. to Order"; Decimal)
        {
            Caption = 'Requested Qty.';
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                StockKeeping: Record "Stockkeeping Unit";
            begin
                // Permitir demandar mas que el stock
                /*
                StockKeeping.GET("Location Code","Item No.","Variant Code");
                
                StockKeeping.CALCFIELDS("Main Location Code");
                StockKeeping.CALCFIELDS("Main Location Inventory");
                
                IF "Armopa Qty. to Order" > StockKeeping."Main Location Inventory" THEN
                  ERROR(STRSUBSTNO(Text50001,"Item No.","Location Code"));
                 */

            end;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Item No.", "Variant Code", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text50001: Label 'Qty. to Order can not be upper to Main Location Inventory for Item No. %1 Location Code %2';
}