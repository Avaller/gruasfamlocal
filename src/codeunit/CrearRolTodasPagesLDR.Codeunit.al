/// <summary>
/// Codeunit Crear Rol Todas Pages_LDR (ID 50000)
/// </summary>
codeunit 50000 "Crear Rol Todas Pages_LDR"
{
    trigger OnRun()
    begin

        //NombreInput := 'FORM-NO RES1';

        //Creamos el rol
        role.VALIDATE(role."Role ID", 'CODEUNITS TODAS');
        role.VALIDATE(role.Name, 'CODEUNITS TODAS');
        role.INSERT;

        Formularios.SETRANGE(Formularios."Object Type", Formularios."Object Type"::Codeunit);
        IF Formularios.FIND('-') THEN BEGIN
            REPEAT
                Permiso.VALIDATE(Permiso."Role ID", 'CODEUNITS TODAS');
                Permiso.VALIDATE(Permiso."Object Type", Permiso."Object Type"::Codeunit);
                Permiso.VALIDATE(Permiso."Object ID", Formularios."Object ID");
                Permiso.VALIDATE(Permiso."Read Permission", Permiso."Read Permission"::" ");
                Permiso.VALIDATE(Permiso."Insert Permission", Permiso."Insert Permission"::" ");
                Permiso.VALIDATE(Permiso."Modify Permission", Permiso."Modify Permission"::" ");
                Permiso.VALIDATE(Permiso."Delete Permission", Permiso."Delete Permission"::" ");
                Permiso.VALIDATE(Permiso."Execute Permission", Permiso."Execute Permission"::Yes);

                Permiso.INSERT;
            UNTIL Formularios.NEXT = 0;
        END;

        MESSAGE('Se ha creado el rol %1', 'CODE');
    end;

    var
        role: Record "Permission Set";
        Permiso: Record "Permission";
        Formularios: Record "AllObj";
        Input: Dialog;
        NombreInput: Text[20];
}