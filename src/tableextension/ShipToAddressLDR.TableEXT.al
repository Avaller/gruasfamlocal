/// <summary>
/// tableextension 50038 "Ship-to Address_LDR"
/// </summary>
tableextension 50038 "Ship-to Address_LDR" extends "Ship-to Address"
{
    fields
    {
        field(50001; "Last User Modified_LDR"; Code[50])
        {
            Caption = 'Usuario Última Modificación';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Name 2", "Address 2")
        { }
    }

    trigger OnAfterInsert()
    begin
        if Confirm(txtCopiarCliente) then
            CopyFromCustomer;
    end;

    trigger OnAfterModify()
    begin
        "Last User Modified_LDR" := UserId;
    end;

    trigger OnAfterRename()
    begin
        "Last User Modified_LDR" := UserId;
    end;

    var
        txtCopiarCliente: TextConst ENU = 'Do you want to copy customer data?', ESP = '¿Desea copiar los datos generales del Cliente?';

    procedure CopyFromCustomer()
    var
        Customer: Record "Customer";
    begin
        Customer.Get("Customer No.");
        Validate(Name, Customer.Name);
        Validate("Name 2", Customer."Name 2");

        Validate(Address, Customer.Address);
        Validate("Address 2", Customer."Address 2");
        Validate("Post Code", Customer."Post Code");
        Validate(City, Customer.City);
        Validate(County, Customer.County);
        Validate("Country/Region Code", Customer."Country/Region Code");
        Validate("Phone No.", Customer."Phone No.");
        Validate(Contact, Customer.Contact);
        Validate("Phone No.", Customer."Phone No.");
        Validate("Telex No.", Customer."Telex No.");
        Validate("Fax No.", Customer."Fax No.");
        Validate("E-Mail", Customer."E-Mail");
        validate(Contact, Customer.Contact);
        Validate("Shipment Method Code", Customer."Shipment Method Code");
        Validate("Shipping Agent Code", Customer."Shipping Agent Code");
        Validate("Place of Export", Customer."Place of Export");
        Validate("Location Code", Customer."Location Code");
        Validate("Shipping Agent Service Code", Customer."Shipping Agent Service Code");
        Validate("Service Zone Code", Customer."Service Zone Code");
    end;
}