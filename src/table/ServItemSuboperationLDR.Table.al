/// <summary>
/// Table Serv. Item Suboperation_LDR (ID 50047)
/// </summary>
table 50047 "Serv. Item Suboperation_LDR"
{
    Caption = 'Serv. Item Suboperation';
    DataPerCompany = false;
    LookupPageID = "Service Item Suboperation";

    fields
    {
        field(1; "Serv. Item Code"; Code[20])
        {
            Caption = 'Cod. Serv. Item';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                error50002: Label 'Are you sure you want to overwrite the service product?';
            begin
            end;
        }
        field(2; "Operation Code"; Code[20])
        {
            Caption = 'Cod. Operation';
            TableRelation = "Operations_LDR"."Code" WHERE("Operation Type" = FILTER("Technical"),
                                                   "Require Serv. Order" = FILTER(true));
        }
        field(3; "Suboperation Code"; Code[20])
        {
            Caption = 'Cod. Suboperation';
            TableRelation = "Suboperation_LDR"."Suboperation Code" WHERE("Operation Code" = FIELD("Operation Code"));

            trigger OnValidate()
            var
                Suboperation: Record "Suboperation_LDR";
            begin
                IF Suboperation.GET("Operation Code", "Suboperation Code") THEN
                    //Si tiene el codigo de suboperacion activo se heradara todos los datos al validar el codigo de suboperacion.
                    IF Suboperation.Active THEN
                        FillOpData;
            end;
        }
        field(4; "Area"; Option)
        {
            Caption = 'Area';
            OptionCaption = 'Base,Structure';
            OptionMembers = Base,Structure;
        }
        field(5; Element; Code[50])
        {
            Caption = 'Elment';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Serv. Item Code", "Operation Code", "Suboperation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    /// <summary>
    /// FillOpData()
    /// </summary>
    local procedure FillOpData()
    var
        Suboperations: Record "Suboperation_LDR";
    begin
        Suboperations.GET("Operation Code", "Suboperation Code");

        Description := Suboperations.Description;
        Area := Suboperations.Area;
        Element := Suboperations.Element;
        Description := Suboperations.Description;
    end;
}