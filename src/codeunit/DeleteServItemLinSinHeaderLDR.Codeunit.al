/// <summary>
/// Codeunit Del Serv.ItemLin Sin Head_LDR (ID 50104)
/// </summary>
codeunit 50104 "Del Serv.ItemLin Sin Head_LDR"
{
    trigger OnRun()
    begin

        // Eliminar 5901 ServiceItemLine si no existe Cabecera

        Fichero.WRITEMODE := TRUE;
        Fichero.TEXTMODE := TRUE;
        Fichero.CREATE('C:\Temp\LogLineasPedidoServicio.txt');
        ServiceItemLine.SETRANGE("Document Type", ServiceItemLine."Document Type"::Order);
        IF ServiceItemLine.FINDSET THEN BEGIN
            REPEAT
                IF NOT ServiceHeader.GET(ServiceItemLine."Document Type", ServiceItemLine."Document No.") THEN BEGIN
                    Fichero.WRITE(ServiceItemLine);
                    ServiceItemLine2.GET(ServiceItemLine."Document Type", ServiceItemLine."Document No.", ServiceItemLine."Line No.");
                    ServiceItemLine2.DELETE(FALSE);

                END;
            UNTIL ServiceItemLine.NEXT = 0;
        END;

        Fichero.CLOSE;
        MESSAGE('FIN DEL PROCESO');
    end;

    var
        ServiceItemLine: Record "Service Item Line";
        ServiceHeader: Record "Service Header";
        Fichero: File;
        ServiceItemLine2: Record "Service Item Line";
}