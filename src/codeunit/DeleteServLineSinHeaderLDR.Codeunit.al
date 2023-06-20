/// <summary>
/// Codeunit Delete Serv.Line Sin Head_LDR (ID 50105)
/// </summary>
codeunit 50105 "Delete Serv.Line Sin Head_LDR"
{
    trigger OnRun()
    begin

        // Eliminar Lineas de Servicio si no existe Cabecera

        Fichero.WRITEMODE := TRUE;
        Fichero.TEXTMODE := TRUE;
        Fichero.CREATE('C:\Temp\LogLineasPedido.txt');
        ServiceLine.SETRANGE("Document Type", ServiceLine."Document Type"::Order);
        IF ServiceLine.FINDSET THEN BEGIN
            REPEAT
                IF NOT ServiceHeader.GET(ServiceLine."Document Type", ServiceLine."Document No.") THEN BEGIN
                    Fichero.WRITE(ServiceLine);
                    ServiceLine2.GET(ServiceLine."Document Type", ServiceLine."Document No.", ServiceLine."Line No.");
                    // Indicamos FALSE, para que no nos pregunte si queremos
                    // crear el Diario Reclasificacion
                    ServiceLine2.DELETE(FALSE);

                END;
            UNTIL ServiceLine.NEXT = 0;
        END;

        Fichero.CLOSE;
        MESSAGE('FIN DEL PROCESO');
    end;

    var
        ServiceLine: Record "Service Line";
        ServiceHeader: Record "Service Header";
        Fichero: File;
        ServiceLine2: Record "Service Line";
}