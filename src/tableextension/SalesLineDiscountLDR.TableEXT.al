/// <summary>
/// tableextension 50091 "Sales Line Discount_LDR"
/// </summary>
tableextension 50091 "Sales Line Discount_LDR" extends "Sales Line Discount" //TODO: Revisar warning de la extends de la tableextension
{
    fields
    {
        field(50000; "Work Type Code_LDR"; Code[10])
        {
            Caption = 'Código Tipo Trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type";
        }
        field(50001; "LDR_Code_LDR"; Code[20])
        {
            TableRelation = IF ("Type" = CONST("Item")) "Item"
            ELSE
            IF ("Type" = CONST("Item Disc. Group")) "Item Discount Group"
            ELSE
            IF ("Type" = CONST("Resource")) "Resource"
            ELSE
            IF ("Type" = CONST("Resource Disc. Group")) "Resource";

            trigger OnValidate()
            begin
                "Work Type Code_LDR" := '';
            end;
        }
        field(50002; "LDR_Sales Code_LDR"; Code[20])
        {
            TableRelation = IF ("Sales Type" = CONST("Customer Disc. Group")) "Customer Discount Group"
            ELSE
            IF ("Sales Type" = CONST("Customer")) "Customer"
            ELSE
            IF ("Sales Type" = CONST("Campaign")) "Campaign";
            ValidateTableRelation = false;
        }
        field(50003; "LDR_Unit of Measure Code_LDR"; Code[10])
        {
            TableRelation = IF ("Type" = CONST("Item")) "Item Unit of Measure"."Code" WHERE("Item No." = FIELD("Code"))
            ELSE
            IF ("Type" = CONST("Resource")) "Resource Unit of Measure"."Code" WHERE("Resource No." = FIELD("Code"));

            trigger OnValidate()
            begin
                if (Type <> Type::Item) and (Type <> Type::Resource) then
                    Error(Text50001, FieldCaption(Type), Type::Item, Type::Resource);
            end;
        }
    }

    var
        Text50001: TextConst ENU = '%1 must only be %2 or %3', ESP = '%1 solo puede ser %2 o %3';
}