/// <summary>
/// tableextension 50100 "Customer Pmt. Address_LDR"
/// </summary>
tableextension 50100 "Customer Pmt. Address_LDR" extends "Customer Pmt. Address" //TODO: Revisar warning de la extends de la tableextension
{
    fields
    {
        field(50000; "Cust. Pmt. Address Predet._LDR"; Boolean)
        {
            Caption = 'Dirección Pago Predeterminada';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustpmtAddress: Record "Customer Pmt. Address";
            begin
                Clear(CustpmtAddress);
                CustpmtAddress.SetRange(CustpmtAddress."Customer No.", "Customer No.");
                CustpmtAddress.SetFilter(CustpmtAddress.Code, '<>%1', Code);
                //CustpmtAddress.SetRange(CustpmtAddress."Cust. Pmt. Address Predet._LDR", CustpmtAddress."Cust. Pmt. Address Predet._LDR"::"1");
                if CustpmtAddress.FindFirst() then
                    if Dialog.Confirm(AceptaDirPago) then begin
                        CustpmtAddress."Cust. Pmt. Address Predet._LDR" := false;
                        CustpmtAddress.Modify();
                    end else
                        "Cust. Pmt. Address Predet._LDR" := false;
            end;
        }
    }

    var
        AceptaDirPago: TextConst ENU = 'There is a Payment Address assign to this customer. Do you want change it?', ESP = 'Existe una direción de pago predeterminada para este cliente. ¿Desea cambiarla?';
}