/// <summary>
/// Codeunit Del PostServItemL No Head_LDR (ID 50103)
/// </summary>
codeunit 50103 "Del PostServItemL No Head_LDR"
{
    trigger OnRun()
    begin

        // Eliminar Lín. prod. servicio regis. si no existe Cabecera

        Fichero.WRITEMODE := TRUE;
        Fichero.TEXTMODE := TRUE;
        Fichero.CREATE('C:\Temp\PostedServiceItemLine.txt');
        //PostedServiceItemLine.SETRANGE("Document Type",PostedServiceItemLine."Document Type"::Order);
        IF PostedServiceItemLine.FINDSET THEN BEGIN
            REPEAT
                IF NOT PostedServiceHeader.GET(PostedServiceItemLine."No.") THEN BEGIN
                    Fichero.WRITE(PostedServiceItemLine);
                    PostedServiceItemLine2.GET(PostedServiceItemLine."No.", PostedServiceItemLine."Line No.");
                    // Indicamos FALSE, para que no nos pregunte si queremos
                    // crear el Diario Reclasificacion
                    PostedServiceItemLine2.DELETE(FALSE);

                END;
            UNTIL PostedServiceItemLine.NEXT = 0;
        END;

        Fichero.CLOSE;
        MESSAGE('FIN DEL PROCESO');
    end;

    var
        Fichero: File;
        PostedServiceItemLine2: Record "Posted Service Item Line_LDR";
        PostedServiceItemLine: Record "Posted Service Item Line_LDR";
        PostedServiceHeader: Record "Posted Service Header_LDR";
}