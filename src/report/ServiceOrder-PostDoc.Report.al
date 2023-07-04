report 50205 "ServiceOrder-Post Doc"
{
    procedure RUNO(var rec: Record "Service Header")
    begin
        if rec.ComprobarPedidoCompleto(true) then begin
            PasarHistorico(rec);
        end;
    end;

    procedure PasarHistorico(VAR Rec: Record "Service Header")
    begin

    end;
}