/// <summary>
/// tableextension 50107 "Transfer Header_LDR"
/// </summary>
tableextension 50107 "Transfer Header_LDR" extends "Transfer Header"
{
    var
        TempServerFileName: Text;
        FileManagement: Codeunit "File Management";
        Text005: TextConst ENU = 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.', ESP = 'Existen reservas para este pedido y se cancelarón si este cambio provoca un conflicto de fechas.';
        Text006: TextConst ENU = 'Do you want to continue?', ESP = '¿Confirma que desea continuar?';

    local procedure ConfirmResvDateConflict();
    var
        ResvEngMgt: Codeunit "Reservation Engine Mgt.";
    begin
        if ResvEngMgt.ResvExistsForTransHeader(Rec) then
            if not Confirm(Text005 + Text006, false) then
                Error('');
    end;

    procedure PrintLabels();
    var
        TransferLine: Record "Transfer Line";
        Orden: File;
        Rutafichero: Text[1024];
    //FuncionesEAN: Codeunit 70018;
    //environment: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Environment";
    begin
        Clear(TransferLine);
        TransferLine.SetRange(TransferLine."Document No.", "No.");
        if TransferLine.FindSet() then begin
            TempServerFileName := FileManagement.ServerTempFileName('txt');
            Orden.WriteMode := false;
            Orden.TextMode := true;
            //Rutafichero := environment.GetEnvironmentVariable('userprofile');
            Orden.Create(TempServerFileName);
            repeat
                if TransferLine."Nº EAN labels" <> 0 then
                    Orden.Write('{IMPR#1#' + Format(TransferLine."Nº EAN labels") + '#' + Format(TransferLine.Description) + '#'
                                          // + FuncionesEAN.GetEAN(TransferLine."Item No.") + '#' + Format(TransferLine."Item No.")
                                          + '#' + Format(TransferLine."Transfer-To Bin Code") + '#}');

            until TransferLine.Next = 0;
            Orden.Close;
            //FileManagement.DownloadToFile(TempServerFileName, Rutafichero + '\Etiquetas.txt');
            SLEEP(1000);
            //FuncionesEAN.EjecutarImpresion(Report::Report7122020);
        end;
    end;
}