/// <summary>
/// Codeunit Updat ServShipmLin No Inv_LDR (ID 50016)
/// </summary>
codeunit 50106 "Updat ServShipmLin No Inv_LDR"
{
    trigger OnRun()
    begin
        // VICKY Modificar "Cant Env No Fact", en periodo, de pedidos históricos

        Fichero.WRITEMODE := TRUE;
        Fichero.TEXTMODE := TRUE;
        Fichero.CREATE('C:\Temp\ServiceShipmentLine.txt');

        FromDate := DMY2DATE(1, 1, 2007);
        ToDate := DMY2DATE(31, 12, 2014);

        CLEAR(ServiceShipmentLine);
        ServiceShipmentLine.SETRANGE(ServiceShipmentLine."Posting Date", FromDate, ToDate);
        ServiceShipmentLine.SETFILTER(ServiceShipmentLine."Qty. Shipped Not Invoiced", '<>%1', 0);
        IF ServiceShipmentLine.FINDSET THEN BEGIN
            REPEAT
                IF NOT ServiceHeader.GET(ServiceShipmentLine."Order No.") THEN BEGIN
                    ServiceShipmentLine.MODIFYALL(ServiceShipmentLine."Qty. Shipped Not Invoiced", 0);
                    ServiceShipmentLine.MODIFYALL(ServiceShipmentLine."Qty. Shipped Not Invd. (Base)", 0);
                END;
            UNTIL ServiceShipmentLine.NEXT = 0;
        END;

        Fichero.CLOSE;
        MESSAGE('FIN DEL PROCESO');
    end;

    var
        ServiceShipmentLine: Record "Service Shipment Line";
        FromDate: Date;
        ToDate: Date;
        Fichero: File;
        ServiceHeader: Record "Service Header";
}