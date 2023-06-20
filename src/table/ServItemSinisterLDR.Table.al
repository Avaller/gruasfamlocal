/// <summary>
/// Table Serv. Item Sinister_LDR (ID 50045)
/// </summary>
table 50045 "Serv. Item Sinister_LDR"
{
    Caption = 'Serv. Item Sinister';
    DrillDownPageID = "Serv. Item Sinisters List";
    LookupPageID = "Serv. Item Sinisters List";

    fields
    {
        field(1; "Cod. Service Item"; Code[20])
        {
            Caption = 'Cod. Service Item';
            TableRelation = "Service Item"."No.";
        }
        field(2; "Cod. Document"; Code[20])
        {
            Caption = 'Cod. Document';
            TableRelation = "Serv. Item Insuranc/Author_LDR"."Document Code" WHERE("Document Type" = FILTER("insurance"),
                                                                                  "Serv. Item No." = FIELD("Cod. Service Item"));

            trigger OnLookup()
            begin
                //Llamar con lookup mode a la pag de los seguros.
                CLEAR(ServItemInsuranceAuthor);
                CLEAR(ServItemInsurances);
                ServItemInsuranceAuthor.SETRANGE("Serv. Item No.", Rec."Cod. Service Item");
                ServItemInsurances.SETTABLEVIEW(ServItemInsuranceAuthor);
                ServItemInsurances.LOOKUPMODE(TRUE);
                IF ServItemInsurances.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    ServItemInsurances.GETRECORD(ServItemInsuranceAuthor);
                    "Cod. Document" := ServItemInsuranceAuthor."Document Code";
                    "Company Description" := ServItemInsuranceAuthor."Company Description";
                    "Document No" := ServItemInsuranceAuthor."Document No.";
                END;
            end;

            trigger OnValidate()
            begin
                CLEAR(ServItemInsuranceAuthor);
                ServItemInsuranceAuthor.GET("Cod. Service Item", "Cod. Document", ServItemInsuranceAuthor."Document Type"::insurance);
                "Company Description" := ServItemInsuranceAuthor."Company Description";
                "Document No" := ServItemInsuranceAuthor."Document No.";
            end;
        }
        field(3; "Company Description"; Text[80])
        {
            Caption = 'Company Description';
            Editable = false;
        }
        field(4; "Document No"; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(5; "Sinister Date"; Date)
        {
            Caption = 'Sinister Date';
        }
        field(6; "Driver Name"; Text[50])
        {
            Caption = 'Driver Name';
        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(8; "Opposite Part"; Text[250])
        {
            Caption = 'Opposite Part';
        }
        field(9; Description2; Text[250])
        {
            Caption = 'Description 2';
        }
        field(10; Description3; Text[250])
        {
            Caption = 'Description 3';
        }
        field(11; Description4; Text[250])
        {
            Caption = 'Description4';
        }
        field(12; "Opposite Part2"; Text[250])
        {
            Caption = 'Opposite Part2';
        }
    }

    keys
    {
        key(Key1; "Cod. Service Item", "Cod. Document", "Sinister Date", "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ServItemInsuranceAuthor: Record "Serv. Item Insuranc/Author_LDR";
        ServItemInsurances: Page "Serv. Item Insurances";
}